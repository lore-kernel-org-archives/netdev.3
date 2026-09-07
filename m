Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850574CB8D7
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795508; cv=none; b=M7moVJBh16Cmw3fi0LE1R8fvsphTO7/MkDFML/6w5P9n9F4XoFN9c1iJcdWw+MLE2qjakkAIRulNKh4OhxIaQSTO5YzbH1+cdt3CHsG/LZyZg3MgtsjiUavYTjS8lh3URKqsVXrqRjIgU6fGkt0ueKl+e4PXbCaczrkuJsHM3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795508; c=relaxed/simple;
	bh=8Me9QJYiCvVFsGys/PK+aOlRI9BVGsj5cSJOS3j6740=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs6rTdZougskDIsOYCgCqpx2awpWHEfqMb5Bxc5Cxh5vaj0+EpHsa+aGQ9UiHChRnVtzsEl+N/15EoysOlOLtVsHCTTiV4ftHUbx1mCU7FxodlAOr1Vkk1uth8ClMvwIaxv/LDBzt8hNVByRsLd5Kam8OR/Gmp5oWobsStvlMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBKvfQNo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBKvfQNo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso578273666b.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795505; x=1789400305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B5gI+zE3N2euLaz2GylL/7/gR3j/SF0RPqPntFnG+sQ=;
        b=MBKvfQNo3NLEmVHRIEzVi9fiTMDDzUeB334sEmEZXbs7pozOCwkjHoe8Tvz8f/Y4am
         pWrcM9HKDM9FeTxKeKhxjohGdl/smYX4Jb33lh2wrBAwjuqaLIlL727MRQqDh9MS7NiX
         vrTebQptTmTo6YndmS9NzIYxFKg+Rqz9e3pfxb+n7JPInihaigyfVOZ9J82vR2xlUm/J
         W7e+IW/MFN8uhSHM28A2VubSr1in9sk0zFfJYo9z2y9Wlk0u3akg8sR8TVugUiq4Brfy
         easZ2D4+AuZ0iSRpkNTajVkynPv5mqyigwl/BN7S4npM/bGD8p+8DWjZ19YYtbOYxiEb
         hszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795505; x=1789400305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5gI+zE3N2euLaz2GylL/7/gR3j/SF0RPqPntFnG+sQ=;
        b=sT8+qhdGH0x9OdTZxibpxba93tbWgWKmI0qnx/HetEGqHPE9Iv8/7EdoV3Ni7DhjEf
         qGlQrSh8B6hnk7yX7CVyZnlfRmliVcPrabAUr7Hsvm7roNRD9ZnYh+JbXuz5wIJXMRro
         z4EbjF5ybDJW9K4GoBJgkiWhYJ42IxFZFsKVZUAPUlVrrR7iUfBiotdkNCqehIbaawM8
         2O4/Y5PWWGMjCoAsUF1r5fWhl7iGZ/XReaxUcWKTyY8niCt3QlM2a9xqX/Tm6EeuimTQ
         PuzXsHhEmYZ6HomRVd/q5vzOgael3YZ93tFzAecDiCXo0zueWvDso8cUynMFlVJ70uvJ
         pYzw==
X-Gm-Message-State: AFuF++nGhqN2pHi7mfR8Zfp8AcoxTyUgNMnwCzrsV5ujdhaD0Pqh8arC
	W0+nI6bh7gTVKqvK7h+a2X63/lQ18lAFhApRHhK5I/QsPLRDiErkO8nb
X-Gm-Gg: AYBFou0/pGXTih4Weq7DalGcZdT9WhtbkXH/vjFBOkNlGMOXBSrXJ8cKbCjV50TOjW8
	EsaSYTaJSg0mNKbilE5kNZoWKejkU1KwNR1SNJDwtuM2Fx0BobAhoYJ3b+Jr02nYfleP67k4SBQ
	z8VG2FxWpU1v5GbWHkgMQ/lcPoy9JGaNL9/KtBSR+seR86kKmyW15A+Z1psorTT9h3VbBaDFUYZ
	688uPuYEm/xw8YcFe7Q19OBdcKWiQhgTyA+nAcRsmCjbzNoD3i/GMridSE93uW49nsbRRFkcerj
	qjIlVqCW+BZe9auTomdJuqRNQcBWG8qW9/vXI9Uj02hegjjkUllW6OB+u0Ueo4A2wBxJ0imjg4I
	Z+TAAX2mQ5QdXrCNYm++bmG5QcisZkeINcfs96aHOH/rKihVw1bJOlzBYLqnnWDEiqGNpdcxWnO
	MZjg6tZeQd3l35nTbJ1jXTyX+GQNAP7x1jthmFQDiRp5/RrZXpeKF9j43sUkD6xj9L8p0HFF8/B
	bO2MGXeEXSczn830BpG0lkGXqvJg/EpW9CDmHq3/q++vPk0dGg=
X-Received: by 2002:a17:907:d0a:b0:c25:32b0:e56c with SMTP id a640c23a62f3a-c260c69b38fmr867347866b.4.1788795504433;
        Mon, 07 Sep 2026 08:38:24 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cdf7asm504779366b.58.2026.09.07.08.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:38:24 -0700 (PDT)
Message-ID: <743631a7-78a0-4bca-ac31-1ffaf3ca7d60@gmail.com>
Date: Mon, 7 Sep 2026 16:38:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: sfc: fix repeated word 'the' in comment
To: Hemanth Selam <hemanth.selam@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kselftest@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20260907044635.7141-1-hemanth.selam@gmail.com>
 <20260907044635.7141-5-hemanth.selam@gmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260907044635.7141-5-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 05:46, Hemanth Selam wrote:
> Drop the repeated "the", reported by scripts/checkpatch.pl.  Only touches
> a comment, no code changes.
> 
> The bitfield.h hunks from v1 are gone: "the relevant bits filled in in
> the range" is correct as it stands, since "filled in" ends the clause and
> "in the range" begins the next.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index b00e7c100566..976a96459075 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -9560,7 +9560,7 @@
>   * DMA synchronizaion. Always the last entry in the DMA buffer and set to the
>   * same value as GENERATION_START. The host driver must compare the
>   * GENERATION_START and GENERATION_END values to verify that the DMA buffer is
> - * consistent upon copying the the DMA buffer. If they do not match, it means
> + * consistent upon copying the DMA buffer. If they do not match, it means
>   * that new DMA transfer has started while the host driver was copying the DMA
>   * buffer. In this case, the host driver must repeat the copy operation.
>   */

As with patch #1, this is a generated header.
-ed
