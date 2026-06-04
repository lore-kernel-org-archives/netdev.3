Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F4342C98
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568481; cv=none; b=LV9OkrGYOCpEZho0T5N0T3mrmXMezu3ZcZZl/BLQQ2yCPQc16f8+JKrLDsgOFEda9krzzSZ/Y4Nv4CMEkHRHYo/MA0pk2r0atXOZZ89l8RFxjnpmNzADDl6XVvITpAoHbtV1NkL0nIfQEp6B9cyRWae7SVgSzCLOdngssSagB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568481; c=relaxed/simple;
	bh=j22bdv9oPvFnjlSd+/YWy+aZ8pdIVUE4JTKplAf6Lg8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LGif24VztHGRibZnYecfoxZRNtP1q9HRnC92i1q3bVl7smwkYD/SZ0rLVA+Wa4GZ8oJoiF1HQ+5SKiIEG997XO5rQFwgpD3zqhlLGsdPyDYcCWG7qUiHC99ealO6OBkAM6JDV2bca16XWzdAM+VS6ikvE6DiAEJEmIy27hwJr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DNCS45tC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="DNCS45tC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD42AA4C55;
	Thu,  4 Jun 2026 12:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780568477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eXdVtjcOydMZf6JHfGJ2qYRXGk9C4bzSq34+tbFiQOo=;
	b=DNCS45tC1g/hdn2LEdDuSLmFoTECMMqjQCXssdm2wbAYK/RkLBJRNNxJ+fGSF8ux57NRXV
	0U4M7wX5yemBoeXemxMvOUzF9cyDe4CwYJ9qh8O+ffCPFwJjZflbUj6Ml0N7pNlf8rUT2f
	NCegmc1lEb1YE4beocYUQltMREhsvEdwf8TRMxhwdXRROZDETyVv0msec5XNtlN0GOnVc8
	oJ438HfGi1eF5mFW+q+LINFnj9hPj4z4u5kYn6Y7Ye6NPJ9mg2DDyVq5GkJ1W6eonNCBHo
	50MdU5AMW7bYzNFXatyHZR2dzXv0HSH0kBdPGRoL165cu+irZJd3+1Ruh+YEKw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 12:21:16 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
In-Reply-To: <3ca7d6b6-1aeb-4e7b-9263-64f4b427d1ef@intel.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
 <508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
 <20260603163518.7bde747a@kernel.org>
 <3ca7d6b6-1aeb-4e7b-9263-64f4b427d1ef@intel.com>
Message-ID: <191ecbc0a4f9b51b9ead8ba559d6a170@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4.6.2026 02:17, Jacob Keller wrote:
> On 6/3/2026 4:35 PM, Jakub Kicinski wrote:
>> On Wed, 3 Jun 2026 15:08:46 -0700 Jacob Keller wrote:
>>> Hmm. I was a bit confused at first by the switch from safe_load to
>>> load.. but we're passing Loader as _yaml_loader which will either be
>>> CSafeLoader *or* the default SafeLoader, so we'll get the appropriate
>>> loader equivalent to what safe_load would have done, so there's no
>>> change. Ok
>> 
>> Maybe I should have mentioned this in the commit msg. I was also super
>> confused by these APIs but IDK how much is this me not knowing Python
>> and how much it's special. AFAIU basically:
>> 
> 
> This is a pyyaml issue not a generic python one I think.
> 
>> somewhere in pyyaml...
>> 
>> 	def safe_load(file):
>> 		return load(file, Loader=SafeLoader)
>> 
>> so safe_load() is just a "shorthand" for using SafeLoader, which 
>> unlike
>> load()s default loader doesn't allow constructing real/binary Python
>> objects ?
> 
> load() by default uses the generic Loader that supports the full spec
> and because of that is "unsafe":
> 
> https://github.com/yaml/pyyaml/wiki/PyYAML-yaml.load(input)-Deprecation
> 
> Basically, loading the full YAML spec on untrusted input is unsafe 
> since
> it allows arbitrary execution.
>> 
>> Why it doesn't default to the C one is beyond my understanding.
> 
> Right. I'm not super familiar here as to how it ends up not defaulting
> to CSafeLoader, but probably its because its not always available.

That's correct. CSafeLoader is only available if libyaml-dev was present 
when
pyyaml was built. Auto-enabling the libyaml bindings was requested a few 
years
ago, but it stalled due to internals [1]. It would also require 
reworking
safe_load() and others, which are atm hardcoded. Hence the usual 
try/except
import pattern.

Anyway, the changes match the usual patterns.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

[1] https://github.com/yaml/pyyaml/issues/437

Regards
Nicolai

