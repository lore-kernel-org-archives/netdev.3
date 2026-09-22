Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71D5616C5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093466; cv=none; b=BDmiPHhHUfONi8Otdr8JNQAY8x34czAzimy7Uk4Dn395HasH2z6YTpIcEQV492VXWlZvmaVR9SLUoQHcLq+1Pc9nl4q+bVY20nDnAOfYjLJxoAtyuXwEB1xQxRaU6z3wWk33qXkq52+R3Nydti7eovVOf0Bi0nBYAXeqjqH7FeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093466; c=relaxed/simple;
	bh=8OcaiIxcxYuSc/C1Jq0Z8DDQ51DHv7iQ0Of65bbeS14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI/Y5O5mvwXin1HJ/ZwicBOuy0JYIGJ8AgHBfFZT2L+Z+iLr4gdZ6n0l2DHP3p4PbIioFpO6k7Zr1X47FoV7bbPFMwKzFP4SxRU3a66z93bKHdU926Syt/rL/nXeOPLStUrQhuE5sd3jmWV/JAeGw6BrxWp4uwKgKXC9d88f9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dslmH2aE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bN6LS0hZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dslmH2aE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN6LS0hZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790093463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0IssFiMcpMRiclnw6rek8fjNkoT/tOuBrqAfsmSoLo=;
	b=dslmH2aEsWUo68nP2ugANt4/yoEh/bXcth7+DNTpTeFZcA2o38Z4WIftsUILPc2cbCoR7I
	oDwyFEFWwsln1OPJjBA5TH3aOjr6yguWeXOUoxOgQ4/k2Vbn59iP7kc5Nm713Ol/yXm6+c
	V9dIXdzV2P8d69aX7EO6n2+3QwbqYMI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-cuEIkRm3NYSXJbT5n4YTNg-1; Tue, 22 Sep 2026 12:11:02 -0400
X-MC-Unique: cuEIkRm3NYSXJbT5n4YTNg-1
X-Mimecast-MFC-AGG-ID: cuEIkRm3NYSXJbT5n4YTNg_1790093461
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso55480195e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790093461; x=1790698261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0IssFiMcpMRiclnw6rek8fjNkoT/tOuBrqAfsmSoLo=;
        b=bN6LS0hZ6PvOMUBzcva90jabKcU8DLNahgmTSETNau08RALJstUlRFjz8FWolb4CTx
         eA10/j434jxfyBARDT4Z32W4FdOKnjKZyCY2NlOOqHzXFkLjhVX345ak1jA7htkrQ+I9
         rEAxfRQpRyGBtOMvJNQyD+g8BHOV4NsjrX5FysZZgs/ptpEqX/btJmXkyOullcY5NjaU
         MqMDhPPiOIeEtWf1EZ0NkxmMH61dFVjT+aYtNFaG7dHczrFiLvyYt70TUQc8lsPWDche
         vTRfJkpnoAuepXXzgp5A8uST95UUq+7nixxQaCeKrn2g05r+6id3LDMdQgk1B8gra/ky
         RHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093461; x=1790698261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0IssFiMcpMRiclnw6rek8fjNkoT/tOuBrqAfsmSoLo=;
        b=IFIuHM83703mOXdV53GhfSDmTq+h6tQuhHKG3oQkpzTG2ek8zvSEd1AgIyVCW1rps1
         S9c0ZlYmLrqaS2Vilr/WO38GY5jJwgj7gT+wCa37PTJdrXUIxamBPSsFRpsRCFa6czlr
         lEAg+kWI5pqT6eUnJQlOZyJ7Mxy4clzVEHJZsLTRLVvalD96pNqfwsiOOgGm3y87vYZi
         7V3O2cauRDF5TX4GIeWf5pS0BZVt8dpcaxx23Yk/ObS2B0tHc+BOg13vwLvrlCsbnR6j
         GKlmEiKKRwh9rl/aobo/VRPFHHYAaS7nVmGpIJxX/HR7EZd/PKKR46rUE6IbyguNHTP9
         HvGw==
X-Forwarded-Encrypted: i=1; AKwUvByCXWNYZv3xqk0EYee/iaLrjnBUMRHtv+XgnazKc/hJxexklSaW1zTxXNBPTexyo2tVA2CFYio=@vger.kernel.org
X-Gm-Message-State: AFuF++nSJiFehMrxA0z3UeDCUlR+MA7c+1VSKxrCBtSJ5HJ2LVEidBLA
	A/sAJCvRbgkA9bYu9kxIju8bGQmpZ+kfR9JXhQbTMjLK3FynkPEro0bl0YecF8W7dkgvkn4SzGK
	ha3AN/ZT7DXnzMyxPNHk9eBi9TBR3wf8ae7YREolHM6fs8HUddptjXlERMg==
X-Gm-Gg: AYBFou1/0GEQqeB1Iyf4haBXKv4M1ja/z2PAhCr9iGemEp/pQPy6DH8iWPGn3T9t6zR
	40uHgW8Ee/yVMOG4MHb3/9joH812/TYOEQ/Bn7ruJaQKE425ohd4Wc00FiYYJFCIFDcJZa060jD
	ayfHmhvaH9Y8DLzQJcGjw5HuBUJvrrCng+7smiudeb1/3IWad/Rc3D5NygpfB9IKFkU5WrJAyhf
	faHuT2kkMs8FO5OlBl4SFncLQzHbnoFppzXxJ/ECTalGrUJByD2vuPA2MEvDdObwR3Dfdm/VuF8
	ivIhQB0AGdtRV+INeFlfAMHth5gO3uCPUCLxbu1pMdsZZCrvD4umTcsvbCw12XLvwcj5Zy38YoO
	BRmqiK/U/6Hh3CPUj/ReCbCQLSUefMzbc7WpSmDBEGe5lZVWVlE8qouxoWDlhgau9SjgKoeRc2g
	==
X-Received: by 2002:a05:600c:354c:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49fc568f76dmr204801745e9.9.1790093461022;
        Tue, 22 Sep 2026 09:11:01 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49fc568f76dmr204801225e9.9.1790093460495;
        Tue, 22 Sep 2026 09:11:00 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1e60c4sm507825e9.13.2026.09.22.09.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:11:00 -0700 (PDT)
Message-ID: <9ff98cfc-392c-434c-a0c0-04dd4fa643e5@redhat.com>
Date: Tue, 22 Sep 2026 18:10:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/6] selftests: net: py: add timestamped metric
 output
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
References: <20260916190409.1222272-1-sdf@fomichev.me>
 <20260916190409.1222272-2-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260916190409.1222272-2-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 21:04, Stanislav Fomichev wrote:
> Add ksft_metric() to record timestamped JSON observations for the current
> test case.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>   .../testing/selftests/drivers/net/README.rst  | 27 ++++++++++++
>   .../drivers/net/hw/lib/py/__init__.py         |  8 ++--
>   .../selftests/drivers/net/lib/py/__init__.py  |  8 ++--
>   .../testing/selftests/net/lib/py/__init__.py  |  9 ++--
>   tools/testing/selftests/net/lib/py/ksft.py    | 44 ++++++++++++++++++-
>   5 files changed, 83 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index 3fe49bce4f3a..a6a8605844eb 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -259,6 +259,33 @@ ksft_pr()
>   
>   Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
>   
> +ksft_metric()
> +~~~~~~~~~~~~~
> +
> +Use ``ksft_metric()`` to report a numeric measurement for the current test
> +case. The helper records the time relative to the start of the case and emits
> +each observation immediately before the test result as compact JSON. For
> +example::
> +
> +  ksft_metric("throughput", 100.5, shape="scalar", direction="rx")

Minor nits:
- find the 'shape' name confusing/unclear. I would like more 'type' instead.
   also it would ne nice to list explicitly somewhere in the doc the suppored
   shapes/types. (If such list is already there I could not find it easily).
- do we need a separare 'direction'? or can it be embedded into the name
   metric itself? i.e. 'throughput-rx'?

/P

