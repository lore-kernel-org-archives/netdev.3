Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105350;
	b=XV3fQqwv+xrIwZCg22cBnPJ6f5/KT+8qfAGqzJoN/NNhlkK17oMCIk9MKZ5LeW4jXicc
	 e0MHO+iHSAXtImm74VOcYZAJ+RnuVoivKUJDOsXT+At/zQv2MPOboiPOf6uipm6rMBA6K
	 2QFTLnaDQCDzvdj4aGrnLnx0Iic+s6IRMDZZjI4uiAq48ojptzYMjq47WyTwvZZy9aAAx
	 daYJUGB9E1MvSUbNcChdaDr2pHR16vv0HdgrJ9PiG39wT/U17V6F1h/Af46d52oRRWoGy
	 XscCx90F97rXdzVyV5mUdpGOQ5NWZFlUQiG8fFpO/D0IFQ7xiTFYfPlC29PBUxtN+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fk4tWvtlQqWKIFqJ5KSuzG0MEcWeW6IEPLtAR2pn3Ag=;
	b=oVGK9qweVp0KYzmbZIA/HjYb2xN93lDZeWhExArclnrPvjYJWTdfOgZozznq10tiVVv8
	 wM24EPlQwJZxwJM8Tl8O7CyfSGR5Hy4uKxqt7IQ763ikIIRJyf0ACaBV9Hk71bSbidqzH
	 uyFNuQ3RV1XI7QoYFrm9uP4F5ToAaCZqtZzeznfkx4dYAXkSPOqF5ez+UCuGG1yE5LONb
	 I0IXYnmtjOSdFdIUj4DRwIdXJjkjSx3gAbTcZG8qj8TD6j0hRz1M8E5ldoWwAFywi1wiS
	 USNvW95+Jr7dIaAiPgacvYr4ffR1+7iLxxQwe9JAPD5DsACTo5UK0iOY2kX7ek02ajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=WiLlRCPE;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169B606A33D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1169B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=WiLlRCPE
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f36c18b75so211416785a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793105348; x=1793710148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk4tWvtlQqWKIFqJ5KSuzG0MEcWeW6IEPLtAR2pn3Ag=;
        b=WiLlRCPEdcKxVRkxZZqDI0Of8j/YUHQ6LS4ozirUJJdpxPXPdnzPLdYFRcQOvo4/Qh
         kaM1KrVlcAdeEQlKG7Dp5+1ZbNXqS8mP0v8jn7zOVZpb+/XX4ik2Un0lMLbRgcwUhbOk
         ZgM7HTwfGtUGBuxb1l3NzKDURXoUGn6pOrbic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105348; x=1793710148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fk4tWvtlQqWKIFqJ5KSuzG0MEcWeW6IEPLtAR2pn3Ag=;
        b=w3PuXngiuPASUkbQd+VjuC92hDBIfCd6lgXhwCH93bEgUYK/6htXlKJDgyIs5h35zq
         PwGmGDwMIK/Ycqo8atlgI/a15xNCjK1nvISBFDBfeOWn8EZXDlHIiu9+SKofpEMkwirn
         QEwkVIufJhpb8uE+AuUd51y+e56RFHzF9urnkTUVJNnOkmEqYYLfqZKwh7Ss9NLST1CK
         FCXxygsWMF9CzV/nR22LDoieW5ZwmQKmkoCKIdVLWTwQakcF/ozQ79xplAStX/oHhKZl
         bVlT57Z0Ck1/0qFbgmY3IC+Z+2cllOa7H4r2nuT1rDlVoaqdGcUIqQxpKw6jZQHw1YC8
         JLgw==
X-Forwarded-Encrypted: i=1; AKwUvBxift0rTOy+jby8v3SP1aeuwFrlMzxH7slno8eNnr4+hjI5oOc7JIRh8pWWGOtP9csDWo934UA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiJ/EbqtbCAGpg46iu2qjKOHwjAMhLLJv9ubYNiNG4fSjbIPdT
	u6KpnZzqpyTQp3XYxgWXypDoBYmVG4Kr7TEF99f8Y665gxXxMUq50NqsMMmpDWaj5g==
X-Gm-Gg: AYBFou1h927GqdyrWgP1DC+VJTYfCFIcZZ2BsqdSuJjalPbZIl+zfCAQI/fabQOlvel
	OfLNsOrFJ5Mg7F44fTHaddqv0efQQdYe3RYCXyD9tQhHKE1qyRVLI0o+gR2Y7oxsgDV+U0qTJ9G
	xLc6gPhSucR05RzWRE8LTJGJis1eKSYU4ZcvmlJI055gJyEeGtaZGaOSmz+LclBkefaAFRpXp2i
	aNZOrkshV1rhC9wshOjVGtP/urwi/8o2fQqK9zxlQAhxHWWsQipNxmWTKbJa6SQW2FNT/3DuGXZ
	Dz/35nllK7seMO7N7HXiZ4KCB5WEd6fxPqRrB107M254LCOH+d9E2eJ4Nd0Y3FnoeBtk39OzDpv
	TuWYDdEBG6IOspp0O07Npjtv7NVvLkfdhzW9N/Pwfgai+F9gQi9Woxe9X0KztMlxtY/g5wDXksT
	IXoEJoVmMR/vzg17PD8QfoCebhiue/gTkHOLaDsV8EMTAAkmEu0qooK020w6UQ3HTwwPzDZoySW
	O5jf6OlGZnSa/9YAnyYS4hZ7MMu2zS1nRXSR80V+yKGTNZuXqo=
X-Received: by 2002:a05:620a:801c:b0:93e:7944:b874 with SMTP id af79cd13be357-940ef93a596mr1396495185a.33.1793105347945;
        Tue, 27 Oct 2026 05:49:07 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-940f0a8549fsm956941085a.39.2026.10.27.05.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:49:06 -0700 (PDT)
Message-ID: <ccf0300c-80e8-41a5-a394-6ec55fddc913@ieee.org>
Date: Tue, 27 Oct 2026 07:49:03 -0500
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
Subject: Re: [PATCH 5/8] net: ipa: migrate firmware loading to
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
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 linux-remoteproc@vger.kernel.org
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 10:57 AM, Mukesh Ojha wrote:
> ipa_firmware_load() calls qcom_mdt_load() which bundles metadata init,
> memory setup, and segment loading with no PAS context, then calls
> qcom_pas_auth_and_reset() which skips the shmbridge prepare step required
> before TrustZone authentication.
> 
> Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
> with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
> the same context to qcom_pas_prepare_and_auth_reset().
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

I think this does the right thing, however the IPA driver does
not use resource-managed (devm) interfaces, and this would be
a first.

Why does "qcom_pas.c" not offer an interface that can be used
without devm_kzalloc()?  What if someone wanted to pass in a
preallocated structure to be initialized with the (publicly
defined) PAS context?

I was going to suggest that you just rework the code to use
gotos and the cleanup path as used everywhere else in this
driver, but it looks like that's not easy.

I'm willing to ack this but I would have preferred to preserve
consistency.

Reluctantly:

Acked-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/net/ipa/ipa_main.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 14ac2d2faf7c..6964395caedd 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
>   
>   static int ipa_firmware_load(struct device *dev)
>   {
> +	struct qcom_pas_context *ctx;
>   	const struct firmware *fw;
>   	struct resource res;
>   	phys_addr_t phys;
>   	const char *path;
> -	ssize_t size;
> -	void *virt;
>   	int ret;
>   
>   	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> @@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	phys = res.start;
> -	size = (size_t)resource_size(&res);
> -	virt = memremap(phys, size, MEMREMAP_WC);
> -	if (!virt) {
> -		dev_err(dev, "unable to remap firmware memory\n");
> -		ret = -ENOMEM;
> +	ctx = devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
> +					  resource_size(&res));
> +	if (IS_ERR(ctx)) {
> +		ret = PTR_ERR(ctx);
>   		goto out_release_firmware;
>   	}
>   
> -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> +	ret = qcom_mdt_pas_load(ctx, fw, path, NULL);
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
> +	ret = qcom_pas_prepare_and_auth_reset(ctx);
> +	if (ret)
> +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +
>   out_release_firmware:
>   	release_firmware(fw);
>   

