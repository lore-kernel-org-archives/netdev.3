Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124319;
	b=mB96mXXUWgS8YIkdYJYqyCaIKef3wGyKGGGGkjeObM1Yc1caqgizpYA4iDOvChkl5Hvs
	 VddMAITTAk+nNopxI5Hw4FzOXwIInTxpeLN+7xxuc5mEDwcqmTI13IUmi4qJBUIva4Czv
	 39FEtmLE65GsYFLETdrYXvsezSjQE5OeBPReFgPAAN+bGbMCgUWUh23T5XLBX2VB4XYfp
	 ACz75vvTTvF1COa3HSuaabfKHDa890G636XGcGWlceZx8w6awIG20tMfvodOqpXdKJ44X
	 kcGhOimuFSRuCIem7U9yIIaFXHRvkVjzhJBDs5VqVwLJ5Hf72Q2fSQb3SPsMdlvQLZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124319;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=C5UG/od4jnm6GtQPKVHk+hFGTYbFM2nx1L5LhnGODlw=;
	b=Oo++xflKJgQ+kWApRmQotJvsevhKckTeeE1E6aPq1QIt6lExc8qOFOTgGUWl/lziou76
	 nV360UlzSUu8IfTdy6l4q8bszaoqTdS+b6vtbrUgosUQXd9/mdH5xPhB2E2C+JvN+eRiL
	 RkAPcNfNndWnFYmOGbSJLMoOlKcVb9B/ieCMQCGBRSuH9yO7b6+sn98ZS0gIdJE8Yq3aS
	 xuz/Uk929EBKn3qwyJhyyRuHbWXI0HMg67SjnOpYRGBfE/UGRayAIt4BXkYB1QFAmD533
	 0dXMvhuliwkAyCHR1Yb+gLhQ5wz/QY+StmOtOtQ3bJZGi+Wbxm57XMPbvRx9kbJw+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e3O9vfjh;
	arc=none smtp.remote-ip=209.85.210.100
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D97606A32C
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D97606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e3O9vfjh
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-843b6f8e2c7so176243a34.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124318; x=1793729118;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C5UG/od4jnm6GtQPKVHk+hFGTYbFM2nx1L5LhnGODlw=;
        b=T/M4PZ8yYnrYBLe/9Hw3HRtVUVC7jcwEyMTPR59hXKZ3Me+lTePCKkYECw7LY5eUhl
         OqFgARWB2CPBNDcc7AU54SWhwPqIbZr17qsXekSHY+J+Ohg0iWCjLIBglpFt0PMQhSvx
         QT3mF9AMQP0fUCxk/98wU38/KelOZtXP1Qhgn20/MYK7rkP9IjR3vr3fq7EplTSpKSat
         tz4ix2uLOH/mJ83mAgHoZjUvQv/yIW+XcSiapCaoTrbMVtV78GGl2vz1TpeNTv7u2qgl
         BSZi42EjOatZXwbGXcwvQdpS5A2O+fzvEjuoyiDjoNvWdbb2xvN53yfXiG8m7YCyNgDa
         y6zw==
X-Gm-Message-State: AFq9FYIlr5bA/y7yZFxF/Wc32b9LgtChkWGE2sO9otxmZoXkee610Qwc
	W41QIIXhoM6KAsYrer2oEMjo/z3Uz8xSc8UuAU2AaR/DLsJvazDmPfAPiwMIHW499XUEU6+9Qfc
	H52+qzpxNtaF14cS1rone10XY4KEnQezrPIIUH8TJWWdFybfo6hafSCPRH2Nj0EY85p4Db5m5s5
	vMKrsucfKGX2dpuhhEdZ5tUBuz/WBvuhZ+mMO31CkuxBYFA9sAtHtAQ0O1AYw9HYDeUjkN2YRfK
	ppNP2kiaOkNzZm8HJQ=
X-Gm-Gg: AYBFou1xVQAGr4NNkiiGXcP3FvSxpYOl94gibEYY2PkdmZuCmKEWGW2P1XTLRGHTJPD
	eYo27ZZXc+H5TNRgh5j7JT9Zco7Z30kGLlv863cegEi06u+5a+UGv+vaJW1YKDC2rNIU5fQ+D9U
	o25t0Xoz6NAa48J3ZeTiIXNSdLtDURlLys7LLxbsc5fp414s0p0xNcJ5hK1y+HOk7p8dlV58Rnt
	2J+0lrZB7lLbKyEWa5Xk1lQLBwLOsArD+l/RjiElJEv0RoKIGnroY/TNPhL46Xdj0OIoQI9oTJd
	yGrehplFdECF0JZ359tZ6DNAYkI6MAk4kznvOStTbAeTVTpuWDIzXY4ayP5lstpe6L6M1TpoDRE
	HxvzVVNm1Dp0o+RY+ycXCypEjVXSMFbM4kZT1IiAYSgliBwLzZ3lhf0Vi23laHkrc/8IrLhfvPz
	Z+nJ/U7H58ZFbQCv6F4vBahxwpzBq+olcJwTQQejv5ncQ=
X-Received: by 2002:a05:6830:44a3:b0:843:b6f8:de3f with SMTP id 46e09a7af769-85ab7c048d4mr321375a34.18.1793124317688;
        Tue, 27 Oct 2026 11:05:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-850faa931d4sm105508a34.7.2026.10.27.11.05.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:05:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a073778890so250387b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793124315; x=1793729115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5UG/od4jnm6GtQPKVHk+hFGTYbFM2nx1L5LhnGODlw=;
        b=e3O9vfjh4hSlcMGOOZf9K7Dxco1sxNhXWZnNpUxfZ1v8f+uNhhjut1P9qnELwJgV01
         Fl8e8WyGawZdm9yMNJhVelK5kzbp8MHczqJfJhT2RrkmDUWG5BJAZMfCR5RROCMKgnVr
         /x6o5XY7g3VfvMPaShYC75qI3ILtK0sKe0JHc=
X-Received: by 2002:a05:6a00:299a:b0:89e:33ba:54ce with SMTP id d2e1a72fcca58-8a6e8e74924mr22338b3a.46.1793124315226;
        Tue, 27 Oct 2026 11:05:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:299a:b0:89e:33ba:54ce with SMTP id d2e1a72fcca58-8a6e8e74924mr22313b3a.46.1793124314734;
        Tue, 27 Oct 2026 11:05:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662d68asm339452b3a.24.2026.10.27.11.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:05:13 -0700 (PDT)
Message-ID: <7e2f2f3e-adfb-47e7-a60f-ec475ab4bef5@broadcom.com>
Date: Tue, 27 Oct 2026 11:05:11 -0700
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
Subject: Re: [PATCH net 3/6 RESEND] net: dsa: b53: constrain SerDes interfaces
 to initialized PCSes
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
References: <20261022225656.1387306-4-florian.fainelli@broadcom.com>
 <179305843878.3134.5626134378768180663@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <179305843878.3134.5626134378768180663@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 16:47, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Ports muxed to SGMII now fail phylink creation when SerDes
>    discovery fails or CONFIG_B53_SERDES=n.
> 
> --
> 
> net: dsa: b53: constrain SerDes interfaces to initialized PCSes
> 
> This patch stores a supported interface bitmap on each b53 PCS that is
> discovered, and uses that bitmap for capability reporting and PCS
> selection. On SRAB ports whose mux selects a SerDes, it clears the
> parallel interfaces inherited from the common code. It also stops
> advertising 2500BASE-X.
> 
>> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
>> index 9818b3922a377..3fabae80dc1a8 100644
>> --- a/drivers/net/dsa/b53/b53_srab.c
>> +++ b/drivers/net/dsa/b53/b53_srab.c
>> @@ -451,9 +451,11 @@ static void b53_srab_phylink_get_caps(struct b53_device *dev, int port,
>>   
>>   	switch (p->mode) {
>>   	case PHY_INTERFACE_MODE_SGMII:
>> +		/* The mux connects this port to a SerDes, not a parallel bus. */
>> +		phy_interface_zero(config->supported_interfaces);
>>   #if IS_ENABLED(CONFIG_B53_SERDES)
>>   		/* If p->mode indicates SGMII mode, that essentially means we
>> -		 * are using a serdes. As the serdes for the capabilities.
>> +		 * are using a SerDes. Ask it for the supported interfaces.
>>   		 */
>>   		b53_serdes_phylink_get_caps(dev, port, config);
>>   #endif
> 
> [Severity: Medium]
> Could an SGMII-muxed port end up here with an empty supported_interfaces
> mask, so that phylink_create() fails for it?
> 
> b53_srab_mux_init() sets p->mode before it tries discovery. If discovery
> fails, the loop continues with p->mode still set to SGMII and
> pcs[lane].dev still NULL:
> 
>      case MUX_CONFIG_SGMII:
>          p->mode = PHY_INTERFACE_MODE_SGMII;
>          ret = b53_serdes_init(dev, port);
>          if (ret) {
>              dev_err(...);
>              continue;
>          }
> 
> In that state b53_serdes_phylink_get_caps() returns early on
> !dev->pcs[lane].dev, so nothing goes back into the mask.
> 
> With CONFIG_B53_SERDES=n, the b53_serdes_init() stub in b53_serdes.h
> always returns -ENODEV and the refill call is compiled out. Every
> SGMII-muxed port then ends up in this state.
> 
> phylink_create() then rejects the port:
> 
>      if (phy_interface_empty(config->supported_interfaces)) {
>          dev_err(config->dev,
>              "phylink: error: empty supported_interfaces\n");
>          return ERR_PTR(-EINVAL);
>      }
> 
> DSA then sets the user port up as unused. Before this patch, these ports
> kept GMII/MII/REVMII from b53_phylink_get_caps() and registered normally.
> 
> Ports that never select the PCS are hit as well. In
> bcm958625-meraki-alamo.dtsi, SRAB port@4 and port@5 (sw0/sw1) use a
> 1000 Mb/s fixed-link with no phy-mode, so DSA passes
> PHY_INTERFACE_MODE_NA. b53_serdes_phylink_mac_select_pcs() returns NULL
> for that mode both before and after this patch.
> 
> These two ports are the conduits for the cascaded QCA8337 switches
> (ethernet = <&sgmii0> / <&sgmii1>). Wouldn't those switches lose their
> upstream link too?
> 
> The commit message says:
> 
>      A failed discovery must not leave a usable serial interface
>      advertised without its PCS.
> 
> It does not mention that the port then fails to register at all, or that
> fixed-link/NA ports are affected. Is that the intended result?
> 
> Later patches in the series do not change b53_srab_phylink_get_caps() or
> b53_srab_mux_init(), so this still applies at the end of the series.
> 

Agreed, this was an unintended regression. The next revision preserves 
the legacy interface capabilities when SerDes discovery fails or 
CONFIG_B53_SERDES is disabled, allowing fixed links without phy-mode to 
continue registering. Only successful PCS discovery replaces those 
capabilities with the supported serial interfaces. The commit message 
has also been updated.

pw-bot: cr
-- 
Florian
