Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146131690E;
	Sun, 16 Aug 2026 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900479; cv=none; b=h+qMti9sBYmJ/XmhEhFoqOQDqqwdj4gzhQWUibel04PZxKBTkMBD+EfkuQ+1dhGSiK8X5nc1l8HyeV3c+/1lpmAu9hUY4R7S3+RXrSU7f7Sx9qRCEwk3664Ep2hCYG5H77zY0pUe7aHTndzzK2PHvujM3dFVtEDgi1Pu920UfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900479; c=relaxed/simple;
	bh=m3CM26TJyklvQ6a+oZKZQoOkDdxUt3WwLBwgAyWG6TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iduk5swzHVGlwLQWSOH/ArzX/fZwwWR4c1YC3QjA29xkFzCmMOpZLOUqkRZujqoydcriUu8sMxhfyCdW/Eyf6yRcZMqRVqczuRyVoxbczPQGXuXj494F9JzW9p1mJUdK1Eroqda9oPtHR4ruM8zA/+VLoFoSZpvEANYb7H76Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ad5oJ7cD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ad5oJ7cD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1LRqaA/q1HOBFuAod1JTwgY3Hc/knxRoge9yUuMTWwA=; b=ad5oJ7cDMwPG+J6R9CSOaeYw2Y
	kg3XZRqZKHIHuNW9bUxNAkUgncyK04YOHMQtkLLw0QaQlnNcwXglqTxDRJWIM5qw9WY3BebJ1K8Q8
	bl7xOPE5uBIoGpXzrTtCR3MEFOlWEt42Ri3fNqQjp17i91rThk1Gtk+AR/IX6wYda6uBxgRAdXUbn
	fpSnWbFCZdI6jSzxub2g7nlkYTvG+o0x0Al8mM1zXV+xr6JuvbRzsfBU5x6+rF/TafaaeZwSg78Jy
	+HKd3lJQlvlJBcQoWlBJ+mP99zxN7QniKQ0qFoIoMrc6jnhi+87Dkdn1BoDzVIQDHWAPv3ZUjeH7n
	jSl8tQPw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wveRN-00000004uyj-2X6V;
	Sun, 16 Aug 2026 17:14:33 +0000
Message-ID: <6b59ab1c-9d3a-4f2a-823a-2cf61c5ea608@infradead.org>
Date: Sun, 16 Aug 2026 10:14:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] docs: kerneldoc.py: preserve headings in
 kernel-doc output
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1786751700.git.kmehltretter@gmail.com>
 <335fec1cd5a3449687f8b1ee8cd46a0f3e455aa5.1786751700.git.kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <335fec1cd5a3449687f8b1ee8cd46a0f3e455aa5.1786751700.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 6:32 PM, Karl Mehltretter wrote:
> kerneldoc.py parses extracted ReST into a detached section node while
> retaining the surrounding title hierarchy. Docutils 0.21.2 silently drops
> affected sections; 0.22.4 reports:
> 
>   Documentation/networking/kapi:107:
>   ../include/net/net_shaper.h:75:
>   ERROR: A level 3 section cannot be used here.
> 
> The same issue drops three Xe DRM RAS headings already in mainline.
> 
> Use nested_parse_with_titles() to give kernel-doc output an independent
> title hierarchy.
> 
> Fixes: 2404dad1f67f ("doc: Cope with the deprecation of AutoReporter")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/sphinx/kerneldoc.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index c1cadb4eb0997..9986df33e37ea 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -38,6 +38,7 @@ from docutils.statemachine import ViewList
>  from docutils.parsers.rst import directives, Directive
>  import sphinx
>  from sphinx.util.docutils import switch_source_input
> +from sphinx.util.nodes import nested_parse_with_titles
>  from sphinx.util import logging
>  from pprint import pformat
>  
> @@ -252,7 +253,7 @@ class KernelDocDirective(Directive):
>  
>      def do_parse(self, result, node):
>          with switch_source_input(self.state, result):
> -            self.state.nested_parse(result, 0, node, match_titles=1)
> +            nested_parse_with_titles(self.state, result, node)
>  
>  def setup_kfiles(app):
>      global kfiles

-- 
~Randy
