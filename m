Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1F47ACD1;
	Wed, 16 Sep 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593760; cv=none; b=bajmNLS9la5fFnW7lsFyvadGTKA7WlAR2fyyGJHKQvmaZrYq/2ldW+GVuw1upbUw6iVA+ItYN3fgxuVm0TH3HgzJVE7EQCXs+Fu7bQFPgVkHB+9TATCMOHkpIdeQp3QOIwn1THasRbTfFA4Xv7Y8P/ONDW09Dyig6HsoXdFhqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593760; c=relaxed/simple;
	bh=/Lv7IZ5zfEfM8gZladiI+LqOK4yZDS02l8twYvRWjZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PB4U7l19dLCoMPHHW50CjCyvy7nr8iGTxRQDZ7LHJ8sWtx4Hj5aSu8tAfZIq4ZFi7AnpkHpEF4AekWZv6xLRUtZlyOwSU27rCRlj2sAZtGzAQA8UNyWtJY/w8XgiYjoOQFdRRqg0CNEpWkAFuu/glp1brbuV/TWPrqzmEhx6s0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MlT2t8uU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlT2t8uU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hI36Dt83+aBklx0mctAZ5voXCECNLVsKWv1vBMRK6q8=; b=MlT2t8uUqAHjVOEfAVvpKLynqk
	s7uz9sdzSbpbuNGds+mV45rbKrkvgrwXKpdP3vHZ9nCXDT+iAGyBiZKxZntBPQcPnWgysNHWeTBP6
	h7YJCZ4kxc3LxCh+2kqK2of4U2CXI9slEHiSCnVG5FA6tgj+4bcqRFkuHar7IjDuHpLksiaYJ6Y3w
	cdUeNgQgkErD/jMKu64ZjY3MiVgUPjwTZCg7faxfbqwfPqgJigjoxXPBGJRSIi3vcaijQDW7wT34e
	eoaYJmGEvMeyV2JZbQMOz22nmEY7u+CKvzP1pEOxyQFdkUT5uCtUlDkUQUz7e5oP1Q9CBSui2ZLWH
	y8ae3c8w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6x5K-0000000A8mG-0TOL;
	Wed, 16 Sep 2026 21:22:30 +0000
Message-ID: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
Date: Wed, 16 Sep 2026 14:22:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing
 regression
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org
References: <20260916211012.16821-1-emmaonana18@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260916211012.16821-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/16/26 2:10 PM, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports struct_group_tagged() members as excess because
> the macro transformation rewrites it to an anonymous struct and drops their
> member names.
> 
> Keep the tag and member name when transforming struct_group_tagged(). The
> nested members are then recorded as names such as fast.order; accept the
> existing unqualified @order documentation tag during validation.
> 
> Add a regression test based on struct page_pool_params.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/0cf8ea5f-418f-45f0-907c-3d1ed4f03e9f@infradead.org/
> Fixes: 2f07ddbd5793 ("docs: xforms_lists: better evaluate struct_group macros")
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  tools/lib/python/kdoc/kdoc_parser.py  |  4 ++-
>  tools/lib/python/kdoc/xforms_lists.py |  2 +-
>  tools/unittests/test_kdoc_parser.py   | 37 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 

This is the same as your v1 patch. Did you send the wrong patch contents
by mistake?

Also, please tell what changed between versions between the "---" line above
here and the diff below here.

> diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
> index d9ad1ddc87dd..ced09504f3d7 100644
> --- a/tools/lib/python/kdoc/kdoc_parser.py
> +++ b/tools/lib/python/kdoc/kdoc_parser.py
> @@ -635,7 +635,9 @@ class KernelDoc:
>                  continue
>              if param_name.startswith("{unnamed_"):
>                  continue
> -            if param_name in self.entry.parameterlist:
> +            if param_name in self.entry.parameterlist or \
> +               any(actual.endswith('.' + param_name)
> +                   for actual in self.entry.parameterlist):
>                  continue
>  
>              hint = self.get_suggestions_hint(param_name, self.entry.parameterlist)
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a53..9e8b3a6b1da1 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -60,7 +60,7 @@ class CTransforms:
>          #
>          (CMatch("struct_group"), r"struct { \2+ };"),
>          (CMatch("struct_group_attr"), r"struct { \3+ };"),
> -        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
> +        (CMatch("struct_group_tagged"), r"struct \1 { \3+ } \2;"),
>          (CMatch("__struct_group"), r"struct { \4+ };"),
>      ]
>  
> diff --git a/tools/unittests/test_kdoc_parser.py b/tools/unittests/test_kdoc_parser.py
> index c4a76ed13dbc..1a8287e99f2e 100755
> --- a/tools/unittests/test_kdoc_parser.py
> +++ b/tools/unittests/test_kdoc_parser.py
> @@ -418,6 +418,43 @@ class TestSelfValidate(GenerateKdocItem):
>          """
>          self.run_test(self.SOURCE, [self.DEFAULT.copy()], self.EXPORTS)
>  
> +
> +class TestStructGroupTagged(GenerateKdocItem):
> +    def test_nested_struct_group_tagged_members(self):
> +        source = """
> +            /**
> +             * struct page_pool_params - page pool parameters
> +             * @fast: Fast path parameters.
> +             * @order: Order of pages.
> +             * @pool_size: Number of pages.
> +             * @slow: Slow path parameters.
> +             * @netdev: Net device pointer.
> +             * @queue_idx: Queue index.
> +             * @flags: Flags.
> +             */
> +            struct page_pool_params {
> +                struct_group_tagged(page_pool_params_fast, fast,
> +                                    unsigned int order;
> +                                    unsigned int pool_size;
> +                );
> +                struct_group_tagged(page_pool_params_slow, slow,
> +                                    struct net_device *netdev;
> +                                    unsigned int queue_idx;
> +                                    unsigned int flags;
> +                );
> +            };
> +        """
> +
> +        kernel_doc = KernelDoc(self.config, "test.c", self.xforms)
> +        patcher = patch('builtins.open', new_callable=mock_open,
> +                        read_data=dedent(source))
> +        with patcher:
> +            _, entries = kernel_doc.parse_kdoc()
> +
> +        self.assertEqual(len(entries), 1)
> +        self.assertEqual(entries[0].warnings, [])
> +
> +
>  #
>  # Class and logic to create dynamic tests from YAML
>  #

thanks.
-- 
~Randy

