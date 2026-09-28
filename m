Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4529472071
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585587; cv=none; b=fF5XwiuAaTypV+xAva27PBdbrZ5LV0+CJJWSp9kkh3NFe6g1Z9HpnC95Z/IJnMCUMrJDPPyxXC50FcU7ehJ6zSSTPyqldrmKrHxgXgKkbPHMPJw0wN5h+pigIiah23rCTeE4nhMimH5lti1HPcHz8HzHp9E9PzuP/ghTsg4mLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585587; c=relaxed/simple;
	bh=CbnlOiwrgHmncRCEHK8eBYKZlo9Jn0twkfrJ72CeDH4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jqf4unu4IUr4aK836I91Hi+XsZ0Aq+KMkfffZNP0iNOiJQz5TVrkNJerywKefQCnLwOu46uxD33TLFu0vQVLMpjD8QpJuKP6xkBeo3eaOUTSxHOQvTSP9Ea8p06bCRXHn8jztcCLt+bU6/H/7kyjo4nX0tX4SUxQDso1SyD6cgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=o6FObIjD; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="o6FObIjD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66731A4A45;
	Mon, 28 Sep 2026 10:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790585579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5vwvhSO8oyyTIk7QqFg/J94Tm3kDBD2j9QHKWduGMr0=;
	b=o6FObIjDrIrK/fuGpEx9pvAxrtSdItBWOtcaoJPvp2+7/x8V1H42jlyfA/jnAUUYf38zrm
	GAua+HGQvWb6bwOLH6zEaztkMSgsd486BiW+ifnFwf5XxQzEfunw24jd7LM5ufbgJS0SkJ
	FWukWxHdJfSphab3a5OPCCuqoxeYmyO5GCNYazHGwP+bPK3X9YxxnY8+BSsPBc4/R6/bE2
	6GLdZkyE9xTS1C73sNzRWl/K2bis7s4mmm7QyK2XeE3P82qzakLPUsnAo1M13Wxbw3bCZ+
	GE8tlpFUjC8Hl+GieJcVI7OQL+a090BfSe+QKMX/YCxQhlNygNxIInShsj3w2g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 10:52:56 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next] tools: ynl-gen-c: keep the type values of a nest
 in spec order
In-Reply-To: <20260924223245.530132-1-kuba@kernel.org>
References: <20260924223245.530132-1-kuba@kernel.org>
Message-ID: <29d4027af70afdb44076e7827c190357@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 25.9.2026 00:32, Jakub Kicinski wrote:
> Family._load_nested_set_nest() collects the type-value names of a
> nest-type-value attribute into a set and Struct.set_inherited() renders
> them sorted, while TypeNestTypeValue._attr_get() passes them to the
> parse helper in the order the spec lists them.  For nlctrl's
> 
>   type-value: [policy-id, attr-id]
> 
> that makes the generated helper take (attr_id, policy_id) and the 
> caller
> pass (policy_id, attr_id).  Both are __u32 so nothing complains, and
> every C YNL user of the nlctrl policy dump gets the two swapped.
> 
> Two attributes nesting the same attribute set with the type values in
> a different order now fail set_inherited() instead of comparing equal.
> No spec does that today, but better safe than sorry.
> 
> Nesting an attribute set which is also used as a sub-message gets its 
> own
> check: it used to be caught by the list-versus-set type mismatch, which
> the ordering fix removes, and without it the generator emits a call
> to the sub-message parser with the selector argument missing.
> Again, no spec does this today.
> 
> nlctrl is the only spec affected, discovered by an LLM scan of the 
> spec.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Doesn't affect kernel code, just tooling, so not a fix.
> 
> CC: donald.hunter@gmail.com
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py 
> b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 2b3483db1b60..15c79849c609 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -986,7 +986,8 @@ from lib import SpecSubMessage
>          self.family = family
>          self.space_name = space_name
>          self.attr_set = family.attr_sets[space_name]
> -        # Use list to catch comparisons with empty sets
> +        # Stored by reference, _load_nested_set_nest() fills the list 
> in
> +        # after constructing us.
>          self._inherited = inherited if inherited is not None else []
>          self.inherited = []
>          self.fixed_header = None
> @@ -1038,9 +1039,11 @@ from lib import SpecSubMessage
>          return self.attr_list
> 
>      def set_inherited(self, new_inherited):
> +        if self.submsg:
> +            raise Exception("Nesting a sub-message as an attribute set 
> not supported")
>          if self._inherited != new_inherited:
> -            raise Exception("Inheriting different members not 
> supported")
> -        self.inherited = [c_lower(x) for x in sorted(self._inherited)]
> +            raise Exception("Inheriting different members, or a 
> different order, not supported")
> +        self.inherited = [c_lower(x) for x in self._inherited]
> 
>      def external_selectors(self):
>          sels = []
> @@ -1394,7 +1397,7 @@ from lib import SpecSubMessage
>                  pns_key_list.append(name)
> 
>      def _load_nested_set_nest(self, spec):
> -        inherit = set()
> +        inherit = []
>          nested = spec['nested-attributes']
>          if nested not in self.root_sets:
>              if nested not in self.pure_nested_structs:
> @@ -1407,9 +1410,9 @@ from lib import SpecSubMessage
>          if 'type-value' in spec:
>              if nested in self.root_sets:
>                  raise Exception("Inheriting members to a space used as 
> root not supported")
> -            inherit.update(set(spec['type-value']))
> +            inherit.extend(spec['type-value'])
>          elif spec['type'] == 'indexed-array':
> -            inherit.add('idx')
> +            inherit.append('idx')
>          self.pure_nested_structs[nested].set_inherited(inherit)
> 
>          return nested

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
