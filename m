Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EF38C2D1
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722067; cv=none; b=cGP49TPhaqgx15+OrLSXqcro0/4269Mn3Elv10k9is0P0UTuymDDwhDB4w6r5PhjLFJvj1aaS1Jsv1hyJesAaQdl++kLuHe8x/11NmRMvUWxPKb3WSoTXPfkrt9CGBRVICkWT28EXr6nhQqizD77MQtXKewkEDbHgfkpRrO0IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722067; c=relaxed/simple;
	bh=qE/l+zbniP1TDPX5DRyNmNMxempA3seMAdhTQPSaFIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2zqHeC9tNNpiu6HUwTz6q312isAD7gyEIM61OXY8vrvxmTM2TkUZvmJsEW/TOoRV7yM/CUJL6bvPupv39PzZo9DCZBrLGJRJleUZdJ/6gb5ahQwRGP2j9ZVmqMD9YKZqvxeokIEpicQErxmVKE8bKrOslgJBCp0Rcwt1sd87zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IH6HQMZA; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IH6HQMZA"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-672b164bdaeso697183d50.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790722065; x=1791326865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zIW+w8L028Ly1vJGzzdfTedRZ4XSuxvHLfykjxpeaoc=;
        b=BL/dcNz89sR3gEdIuGXHwyljl0cSby7UAvQqFQEXuQb+6MiluafyDxFf3fX3R+0sNc
         ijPGKQCOt+lt0SePtWtimahc46X7jhaMjo4vf4AsNnrU7tIcNKeYhRh/918ggs0zG7zx
         7Fr6xdrUmBPMWfzNZ8Jczt4sPzjiJveKAzmyiM+A3dwMcsk+mjq3q5fS5yOuO2veddCr
         cIDhYz+Er0acgQFJGs4IDOLIT3MVOGKW1VZGQciv06KbzMhamvrXHC6CQ+9/a7Xtjnsw
         eAD3Km4ze/hR15qCeHEuNMir5lgjatqai6BexcozIHn6dMBpdz8jyiQoLofJ989fwZ60
         97qA==
X-Gm-Message-State: AFq9FYKohcSWrgz+sUANSn6iI0vao38/R2GPUwUry0KTCYIUDGfoA8FS
	AltnOVtNkj2O5ruC9wpG/epHUWYsO4rJXj48o5MM6kGnryUk9mCuZtFWDfq0S8qbgB0FBZQzeDD
	2Ox7f1rgUuNpS3FLQbqYpPBs+h3KMSYnpDmTrkdGuX2uonjYxPh/m6HQ/gwx+rasj9RRZ3i/Ej+
	h/xwvt7EDvhbJr/8FiXtfZYFz+Sq4iNsICZsoEZrr9g96e7tcwwgJvtW1V5Hm2WRhTLOkgvCatt
	ab1Rj1RIQ==
X-Gm-Gg: AYBFou3d2+fYj3OMnziC7qzbdxylph//hso/kL4cM2zGast3+VAe+XYV79lII4O7yH2
	/LZNYO5SeYeJZMetRPdaDl4AloH4LYBsEaY7i3bs4mPLQyeyMf8V2wwSZlqCPhNlbCONSI+QcRK
	E8IMrNhcCuVn2lslxU8N0U9nHnKCeqhrd8yz0lOcAOfbcsM8N+ZNtza+3/7pxZMiMzQ5cXaLN9y
	YhnF8eMlvYxbgYZLyYl89tzmnD7NVjKTCFWTAkgXkJAtJ/WKwZOanZDlHOdbdgwvGvOgdX5OlxL
	KGVHXqBKnsWHDVtJkZO9bjmoOln0XRNSKnlTbP4YES5EOhe2PjWoZxTwa0BkMdAI2hKy3Qn/fCC
	YOOPhX2BDD/CIUzkpSJshqohaUG58vvtoLHFldjvYIalS3T/sG4P50DdcqcRrOH5M2G722xrYwQ
	d98glB4qXmW4c8iXO0Gas4jsGoAmBDE8fkA0fz
X-Received: by 2002:a05:690e:48a:b0:66f:b219:9ed8 with SMTP id 956f58d0204a3-676440509edmr236407d50.23.1790722064349;
        Tue, 29 Sep 2026 15:47:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-675b2834f6fsm466829d50.12.2026.09.29.15.47.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 15:47:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so17616294eec.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790722063; x=1791326863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zIW+w8L028Ly1vJGzzdfTedRZ4XSuxvHLfykjxpeaoc=;
        b=IH6HQMZAhTOTyfhB16Bk+BVMwGY7SkUtWOGAtuzgZmzEciBrSKSQ0+xEpP+qXu+w6T
         lA2FYa68Z4fFtvLd5DyvQqeMSu8T1mrJidHZMv+lJpSuZ1ji/mCV1NHfRN34czF6j2aS
         7fxal576mHqoPvlDH3qSuRw4988jt9o/l0LZU=
X-Received: by 2002:a05:693c:8382:10b0:34b:7e89:99d with SMTP id 5a478bee46e88-34c6558b73bmr966816eec.36.1790722062689;
        Tue, 29 Sep 2026 15:47:42 -0700 (PDT)
X-Received: by 2002:a05:693c:8382:10b0:34b:7e89:99d with SMTP id 5a478bee46e88-34c6558b73bmr966775eec.36.1790722062007;
        Tue, 29 Sep 2026 15:47:42 -0700 (PDT)
Received: from [192.168.1.117] (162-230-227-228.lightspeed.sndgca.sbcglobal.net. [162.230.227.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386b6a49sm1862314eec.17.2026.09.29.15.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 15:47:41 -0700 (PDT)
Message-ID: <c07041b9-ca73-447f-bb24-d3fc8e77ca79@broadcom.com>
Date: Tue, 29 Sep 2026 15:47:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com
References: <20260929192216.1490017-1-justin.chen@broadcom.com>
 <27f4423822acfaa3f121e3637ed173e0@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <27f4423822acfaa3f121e3637ed173e0@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/29/26 2:09 PM, Nicolai Buchwitz wrote:
> Hi Justin
> 
> On 29.9.2026 21:22, Justin Chen wrote:
>> When the revised suspend/resume sequence was introduced this led to an 
>> edge
>> case where the TX is left disabled in the following sequence.
>>
>> 1. phy link is down, so UMAC is held in reset and then network interface
>>    is WoL enabled
>> 2. Enter suspend, bcmgenet_wol_power_down_cfg() enables UMAC_RX since MAC
>>    is in SW_RESET
>> 4. Enter resume, UMAC_RX is left enabled. Since we only enable UMAC_TX
>>    and UMAC_RX in SW_RESET. The UMAC_TX is never enabled again on link 
>> up.
>>
>> Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
>> Fixes: 88f6c8bf1aae ("net: bcmgenet: keep MAC in reset until PHY is up")
> 
> AFAIU before 254f3239dd07 resume always went through init_umac(), so older
> kernels shouldn't be affected. If we drop the tag for, it would save some
> backports to the older LTS kernels.
> 

That's a good point. I will drop the 88f6c8bf1aae Fixes tag in v2.

Thanks,
Justin

>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> ---
>>  drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/ 
>> drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
>> index 96d5d4f7f51f..984432952963 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
>> @@ -253,6 +253,17 @@ int bcmgenet_wol_power_up_cfg(struct 
>> bcmgenet_priv *priv,
>>      reg = bcmgenet_umac_readl(priv, UMAC_CMD);
>>      reg &= ~CMD_CRC_FWD;
>>      bcmgenet_umac_writel(priv, reg, UMAC_CMD);
>> +
>> +    /*
>> +     * Mirror wol_power_down_cfg(). If only UMAC_RX
>> +     * is enabled, then we must place the UMAC back
>> +     * into SW_RESET.
>> +     */
>> +    reg = bcmgenet_umac_readl(priv, UMAC_CMD);
>> +    if ((reg & CMD_RX_EN) && !(reg & CMD_TX_EN)) {
>> +        reg |= CMD_SW_RESET;
>> +        bcmgenet_umac_writel(priv, reg, UMAC_CMD);
>> +    }
>>      spin_unlock_bh(&priv->reg_lock);
>>
>>      /* Resume link status tracking */
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> Thanks,
> Nicolai

