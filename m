Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA84CDDCC
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965616; cv=none; b=tn+JQdjbefBxYiohQ1DfrrGvGOfJCjjvZAzJK77/A1kZjpV663u/1f5X8toWwcIEv0hnTB+yCnUko1xbYsHDi6m8oB1P5NrPHX1bc6M1b84PX6CLkeoh/B+FtTilito+J+1F3Pl6Er5lMOeLneKl83btLdg3N+UQSU3VEk2MCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965616; c=relaxed/simple;
	bh=B9d/kmm3izPtvmFc11chF3VEeYuL/uSaRibIHmGk8O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXMiMjVNRuNG1bq2dZu+a1SWoc0mIXcFk1lPH8wDq54yAOqzuMEYj9dAXDQMbqIDX+/+PkF+vZ14026OxU72pn/HZiovKrY1dQ158WMuRFLT1k4l211oneNSaKriVVpycOg9ari/BJxF55PdLht1EG9o+FwSxWBbCCY052qmdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6lIz1F2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6lIz1F2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so1196205e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790965612; x=1791570412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tor4k7A1qPaAWjZB5/5Oa+wy8r9Vmav0GNMyiCPqDnE=;
        b=e6lIz1F2bJ+tkYFCEQmkav8toHD2fW9+16TLBHJAk5StJGPqKVNWoJuhW/LZDy8piL
         wHixorV/j78oZdedVeUmNch1mCUBDqyj6LUadFRuCnbeWqJbxghpcwrLb0u6Y9iXstNm
         U+oBivUCYyrPJ5xVw+fKgQoOuQEA8VjG/YrCsgqxn6zIYfsN86WbJf1kq/FBvL+sfiUs
         1qiU2/hzsK1cUfbgNFc4Uq8RRo1JNcgHQlgumYQxIkiFQE30AQ3hTBwSAOflW4mgsSgY
         dGa5+bqGmrx528DApfyDfaW32i7eKyofBRVSX1r4MiMw2o5exR3E7zgUg9DPw07gT/aJ
         vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965612; x=1791570412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tor4k7A1qPaAWjZB5/5Oa+wy8r9Vmav0GNMyiCPqDnE=;
        b=p/c8uVwMG7gIUNB6AWDMfaoQsXu12dp9hf1nF+C4riLR/kpCuwkp9L0TN4zmvdwy4C
         Eet9qPq3LU1LEmHa22Xy5m4K8vn3KXqcu5zYw1hpkDB6pdoqt48uOEV/xAu9hPG/npQW
         tCyzllBA0FbsQXfZty29BqKSnE7TSrVISeKvH7XgDCW+hFmnvycS/oBsdrPjrqsLKHrY
         Bh9OLqzJ9RoijPtkq73S4XFlZhlyGSQvi2VsHbZEsQBT9qUppK819/oUUYK8poQ9j7Gz
         hD1//Ka5pbdRMzV+KilEsQdOft+v9Tt3WjkRJOMDJSvZdgio6AmEiQ+iVbqJ5PbW/YSK
         utpA==
X-Forwarded-Encrypted: i=1; AKwUvBzP02wsi5gjQH0hhUU/pqHfRY85uAi+GVBYv0WQ/GDufTxDwIIGMa7GYLQqIOc4K2PYzs/QsWw=@vger.kernel.org
X-Gm-Message-State: AFuF++m0L/yutmCecS8S7VqY+ND38Fx/0rQqby2IA2UrbGysGevXcUxK
	/6ckaSW70iKy6n95YZonQjpupiNOoZ5hcaD8O9PivIu+9/uwkJILEUhAnRfl1L+3
X-Gm-Gg: AYBFou1xElmUBueCcdVUYkJvdO/zzT1O1wdr3UGXTB0uiwmL7u8vqzylTcqdV4PjuUH
	vWqZ/Fcc8X2UmPFH3crx8Ht2WVgh4eshoIo2KmU0q/Zc9guoyyGcI/f+W/tIIZr95i9RHbRZ9AT
	QZnuv5elfEiJQ6toPyFtdm4AlMm+c1tyLVTb5FcfFX4ubkUR60Q2T/k1MLSnd6sOX9lOBXQmZmQ
	Y3vqdZkTej/piFn+6GuHGixiICpqmmQhe0EX/Rwg+lEEqIUiDdysLy6pLSp8rG7emM21DQbQKKx
	UOeahPBnM4WPtZ3N301/6V5cai50PqdgPmbYV1r1MC/WPjudYrG361MyO7JslmE6bgQ08L52EZs
	pQEoJ/1Quk+n6uMyBFFdC0N2ZPpH1szwEFhCs/3D5SjQgc/X1fU74tgVXvFwY78kPp8Xy/UGwOb
	ZCp5e+iFe45wLHRcmCoXH38I5jLFyMErlv2Khct+tPNCV2ZT5H+LNe/OJLEjtreh5WZuAtDc4vC
	sDjgxJB
X-Received: by 2002:a05:600c:3e05:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-4a0276a0e94mr60145295e9.26.1790965612096;
        Fri, 02 Oct 2026 11:26:52 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027741586sm101502055e9.14.2026.10.02.11.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 11:26:51 -0700 (PDT)
Message-ID: <802f1969-f548-434d-8b8d-39f9df6f033e@gmail.com>
Date: Fri, 2 Oct 2026 21:26:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in
 nci_core_reset_rsp_packet()
To: netdev-bot+sinfo@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930224940.725976-1-omermetekaya0@gmail.com>
 <179080888379.31693.9678596349950606516@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <179080888379.31693.9678596349950606516@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 01:54, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

manual code inspection.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

theoretical/found by code inspection.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

