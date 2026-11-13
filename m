Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596640;
	b=3d/5o3P23+JtSqpeu8wmCJAUg5HTthFq3kEVcyMBZVAD/9CZj3fwrYFZ2tiHf/xZnbMl
	 RrrJL1oWuYI4u5q75wGurRWhf8w79pbR0z8u3tdTyGaGQswNpqDGBxmHALauuE4KjsESS
	 UK7iot7oMVPbGKWavflDz9zYX4hTCLBrEYYYh4ptRHrFk3BvedwVHRqu6FHJpWA08FqZn
	 GMvkanGDwZZHeQOOerG6gCugUDNN8n2TwH0xAEU4JEnBNGK9+t6Ja68CnI+oNdTchOaLK
	 o6KiQ2payDp4xyrw7I+358OmBwETt05dmgR9v+zoCi8zeXhAW13SLhMO+jjtZrMKeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5v4390+5+0gQiMHK1KicuB/Gp64Vkth2gdQzKankJ34=;
	b=hF6axuueRbC59+nlWguynCzpL8L+r9r3qtH+VfB1SwrbVF7ss343uRCoohlLDp0LW0Gn
	 m2eJeh2e+HFhuP2IihVlyyS4a5vFyg+xVeyCNb6cwM4cVo5mUwO4oZ+6MW1i3rEegq+Zy
	 PHq5pVenAy80SvF9Xh8CiAEluv+gY81RDvqJ6HIA1w2BNSghJ18GYnd3vUYFz9mM+YLvQ
	 0sWZA+6dnco8w5BDtnsx+8YFeWuSm0c/BvKYn8j2fpYDe9gdckaLhjyhnzL8vi6+DsRQG
	 QJG20eNwREzFnVzBCtifYFKqBuNl5WgTUiNu0S/iX4XcfF4cGwR5l4x0Mp4dITjvg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=OBl7H+i6;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150E606A336
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6150E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=OBl7H+i6
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ea16d8072so17901976d6.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1794596639; x=1795201439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5v4390+5+0gQiMHK1KicuB/Gp64Vkth2gdQzKankJ34=;
        b=OBl7H+i6ZwCYqyZENMFkOks9QMvP3Q1O5CrDefd7QEnoWxR7Gzg2PWplPwjprGwO9m
         ONLcl2A+SicRV5yCDWOMiHwCcJzaUmNARnD8racf2rem5cydfXkKMyTLGas/HjHQXhp0
         TTMH+rLW9ObkrPLd+QQ+P9H/NwQsFwau/hQwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596639; x=1795201439;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5v4390+5+0gQiMHK1KicuB/Gp64Vkth2gdQzKankJ34=;
        b=WQZzNacA4xtljorFHVayWBCjj6SlrH59mk7b5YSf3QekP65mcpum4HW/IVYSFoxOeK
         0NxfmBI2sNzr43i3h60P2+VvkhvgHI+pbhNmOrQ+zKma5hx06aqB6cI0+mCwWK2BmAwT
         GC12wjECznbj+pA07GdMhFT9Gl5m3F+zD5UphixjcHsTUTL/bikR36ScejunQKbWwKLz
         M9I5br4QLwncRvVG9lkqYAB9sEcwJTfQRDSELpKe7rHfayVoRj1/+iQKT2XnpWYy1b5Y
         ycDbALsXvcWJ2tlA7Ld3/NNemfLf8FTgqOfuHWAs7DgeJMH+yfnLxzRNVuyU7jmE5sQi
         ImlA==
X-Forwarded-Encrypted: i=1; AL+hErFNihlfEyxOXUm4LoVBcEz6SdraP3Mo9Tky7td6mUOJ7uXAV/qcEuosqfYt+wBWhkp0E5mNEvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0ffRdcjmbgeFqT0b48SKibi1cvh98u8nl9NJ1/0GB0NxTMspV
	yZSlnX7NuzB1rpa5oBuvpo2z6zJrX+KBJ6MqR07NmXCXlP6Lo1whkiDVLIKNjmGXOg==
X-Gm-Gg: AYBFou2hwCJPMi3gvZ39dMh3RoP6Hg99QErBv1IkwyRiAIdkrTWCksUa7B312PWuaNM
	YG59j+8oij67KBhqosV6gqJi8FchnkdSMRAn8HNPF2bocDqGbXrPjQZLkyXymU7L988xULD2c62
	I4WR/3BZG4xfxae+mE2J+s9AtKvqWV4dEy6MjUfylGiZ5FodY+4OofMBSJOjycXJ3lG/M2McHZw
	eKp3EU/AEH8kuFjAUpBmWi2orzcE2ynJz6jbPLQpoNixykQqKYZNAKFM4lMjLp7sXHdGBzV2FQB
	w0RGwgzrNIo8rBqzHrBLhdfCW/7KQXcQMO9uLeov6Ot+umI/IkqIOz6RbigCnYg4SdNM+/yu2JI
	jAMWinBNfsT0uzqkuuRWg9VSkZ2tzOWRAdPsIcsX1TMxoWOXGm3dHAJcYtimQMWexwtO2Sgp/q8
	jB+9FR0h4Fk07WXsYn2FtiI38lRHi9MqWhFjW/WB2lDHahRKahrX9GugUgF/rlFg0exxaRCFhAQ
	f8N16GZ06DwlIALTj7p9PjTBpWdpdiOusWsfpCNv6taEgS+y9av8PYyFhYq1zheEvQBG+/vB/nI
	Zu/pVSqrRhpLqe0F0EyOnxsB
X-Received: by 2002:a05:6214:4409:b0:91c:74ce:a452 with SMTP id 6a1803df08f44-91f241ddd3fmr55479136d6.46.1794596639018;
        Fri, 13 Nov 2026 11:03:59 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-91f23d780e8sm27000686d6.27.2026.11.13.11.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:03:56 -0800 (PST)
Message-ID: <1b84bbe8-28b6-4a74-af0c-5b9cfdd8b394@ieee.org>
Date: Fri, 13 Nov 2026 13:03:53 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, Alex Elder <elder@riscstar.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-7-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261113185009.157893-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 12:50 PM, Mukesh Ojha wrote:
> ipa_firmware_load() calls qcom_mdt_load(), which bundles metadata
> initialization, memory setup, and segment loading into a single API that
> does not expose a PAS context. Later it calls qcom_pas_auth_and_reset() for
> TrustZone authentication, which is the intended behaviour. However, a new
> qcom_mdt_pas_load() has recently been introduced that works with a PAS
> context and can handle everything qcom_mdt_load() provides, along with
> additional functionality such as shmbridge creation and retrieving memory
> from the shmbridge buffer when the same remote processor needs to run while
> Linux runs at EL2.
> 
> Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence with
> qcom_pas_context_init() and qcom_mdt_pas_load() and
> qcom_pas_auth_and_reset() with qcom_pas_prepare_and_auth_reset().
> 
> Acked-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

I haven't reviewed the rest of what the PAS library does but
I trust it does the same thing as this did before.  So thanks
again for implementing the non-devm interface.  This looks
good to me.  My ack is already present, but I'll reiterate:

Acked-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/ipa_main.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 14ac2d2faf7c..0a37741c2285 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
>   
>   static int ipa_firmware_load(struct device *dev)
>   {
> +	struct qcom_pas_context ctx;
>   	const struct firmware *fw;
>   	struct resource res;
>   	phys_addr_t phys;
>   	const char *path;
> -	ssize_t size;
> -	void *virt;
>   	int ret;
>   
>   	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> @@ -615,24 +614,18 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	phys = res.start;
> -	size = (size_t)resource_size(&res);
> -	virt = memremap(phys, size, MEMREMAP_WC);
> -	if (!virt) {
> -		dev_err(dev, "unable to remap firmware memory\n");
> -		ret = -ENOMEM;
> -		goto out_release_firmware;
> -	}
> +	qcom_pas_context_init(&ctx, dev, IPA_PAS_ID, phys, resource_size(&res));
>   
> -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> +	ret = qcom_mdt_pas_load(&ctx, fw, path, NULL);
>   	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	} else {
> -		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> -		if (ret)
> -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +		goto out_release_firmware;
>   	}
>   
> -	memunmap(virt);
> +	ret = qcom_pas_prepare_and_auth_reset(&ctx);
> +	if (ret)
> +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +
>   out_release_firmware:
>   	release_firmware(fw);
>   

