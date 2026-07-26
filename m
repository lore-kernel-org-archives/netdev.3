Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A1379981
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095418; cv=none; b=kQLjb1xXRGqdR1PrX7mzWU2skNVD76iTdp8VSomy8NIVkxj5uMKOqW0qQ6MomMEc9mNrBbTISMJGmtRa50t2DBkPOyopZ4/1P6W0M2rZiMZI422+o1F7bGtFSDZxfCF2wkGG4/LoL7fLBDtUCEAIQAo0lXfyt5FSlA130Pg4H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095418; c=relaxed/simple;
	bh=TpF9WgLebJYCuyLXpfcMFXCb5PMqUSoNgdvwYs1bzrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcA+Dl0Znu2xLSbPbDyIG6yuWAlQPoYxMBM8IBkNP/ZW2xujWT3vwW9IiL294Ad1eqEXjPbKxuxVsVT+E502bvY/xHzru7YTbwHxkY0ontQm3fDOdoU3IKYRg/49hm01SDY2sFJL5+jMiTrBByATQX5MBB07Ce0EgE43VWuQZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VY5HKdwE; arc=none smtp.client-ip=66.163.191.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VY5HKdwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785095416; bh=FPPAU4Jx4M9kRoEGk5rhdz0gEfdLS5c+oPJz5cZ8ECU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VY5HKdwESNRmBolzb3+GXRKsMSMd1ZbW3C3j/sbbM1Vx7Il1HdshjNpQOlQTfA3hCHDucQOZ/pH2BDT8uZXbQ2Y1youa2eNm1kPo3HwwrH9rlpvopyqBt6Kw2osqJblOS/SbsGr224LfiCItKnPCvFu0VVoAhNr5TWP6ZmafM6y3VC0Jm+JsSv5OkORE1LU7uMni/Hc6TwULEdKuSy+dWJ9YiwYQD+1nF8Ql/3iPTp6Hjj+e2SLqOlwpgbnpgPt5+GNsor/WC6fWrf9Mv2rbZ0snWRSpbuBM7URM4/UeXaoHFcXnsWT+YVkpUtv4VNoy07HOaWQXYIRPdPOxmxXhBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785095416; bh=+qWwXDeX6AY5g9HJfe5Xv7p7tQrGWPrNIFczsfJcPJy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FArcMLpT271id8xo3vgCCAzGYanYM4Xsu/l4zuk+1KmOvHhZMXfOsyzlAmh09S5OKWXTAOlTjCxXuOQytYIKvab7i0AvQM6zTVDLK4joDv2vKPgt0agxQw5s2zyMWnGpBV+pIGty4F/beFzx+liSB2OtKpCMwhgy1UYtEfl3HvLG5uRFnzea30MbPvcOpSJsRLIFjcFbRg4FYs5a5Rqh9MppZ3dazaZGwKvzXljztOjEGllpNatDtiqW0ucUS/6yHr/2zAemmkyq0ecarS648Yztz+cBvp81OQq5obiAiKixtq86j7+kuogOdSHY0Ae8UZMRPHy3T7xQUjwPXH8dLg==
X-YMail-OSG: gDKsKe4VM1lr58QEc_kKyV.bP9l3VC6r_ISTcjezoLVAjQP7xZgZpZhUV23YPLV
 7T6g9uqjmpkJk79E8BKiBrBVxklBXAfmHgbhtgteryo7Wvst1Kj2QkNtdZjAYWXe2HcDdfMwgJmu
 HwD5Klbjd0e3oUysXzL5.DP5NAkPIkmk9o5XSRiJ8NrdhlN.oVOV1RnqWqTyqpqmkwrT.PNMBA9P
 sujbgjbqlnoaDQK7sWq8hxkmSABiN6g1I.Wc5aOCIvxdCoHAHpHbvempgfWXR.bXwBMny0gcbwro
 SZDAXvpWZEo92VGz0MYqaf75KeAIugZm2j01zLPv.s2wWcJ08stE9jE9ht0WhRdS2v2y5M40lA1z
 mVR6uMh6_9Xcn4VpIBlAfr59fX24kH2.8oqiz4o_hSGvwdj7xpCo01_bAySlFVCwBXeiBomy8jPn
 VatApaNwlBTJ1ijGkJs9zG8B1928dIB6VW4fwTMwdlpK1bEhTYT10Z0kqlEb6MQK1wD4ansoBZoc
 am7TH3A3IiXYYK7B.bXzX_UPSWXEdu8f2RVFOIjcIawz_.wZhdbZdfvoSuGVY6HjIbIqlyhQvmOQ
 lKB.2n32ht31eY21RA_QS5YziLsTRcMLne8h3vNkitr7gTUjlHuRaJGu.gakbAkcDWWkCtGDsyrb
 8wqfV.pWizRpwAZ21PGRKXRZbJ4mOvE0887G6N57wYAXOi0FXfLsQP2otzfXwK8GNT_9MU5ddN5A
 IcqM1M1CVK8uFuFoxfmryoS4oOZQrJRSL0okuTVHP_lrhA6gmfNqLDclrFbtawAt9gzeb1Hnk7Lu
 fnQgaTA0Vfs5Tzow028je3Bv5wXhe6GB7fJEg.ZhJtPS9h_fXmrMmzO3uep8h1DGfBxUKDsRd81T
 g0Dd1iDOenWvuq4isLNCeyNi8byuh2dVEgBJ4CjF.Tqu9Ko2L979z8.XzSff3o3BVhRKmo4LbhWk
 R3ZTlqYybUdArPgxzr_AE7F0aiWkr1NHLJPWvAaSbMpELQa4r31_AZ1iS6IrJQPGgG3JsAL9pOqG
 0d4d7lr0mPpmyql1T83MriRqYvdRw7mSzKOBj3_UDy.6A.xjIyeY7yy4cDxiToFd5iDD.RZXN6PE
 jldtpvjp97EufMk9.n26ICDRbqxst5ojCizEMj52g1cayIv5Uc0WbWRmjqV43HI47mXm_LRoLA0N
 jzzqq_504XHIeziBsECjggPnZZEzXaefC6NsaTALRlEVYfuZ2KPS2YS7yraVfqOLDEw1b91qUWBV
 hXmz_AJ6byq.e9_Uj1X9XUAQzVglIttJkmZ5bmbnV_BU2.kba2N6ZTcalhNwLIaNzuQtUpF191M6
 Knc37Oe23w4JkIt6VL1Pd1jG1Kiv.WSUgo.o8.hOF6zd4pfActxr3idjrj1pUWVRtbzvx_z025QI
 QwhTrPKzU4dwlKPaMkgtoIia088y5gzAbLoFCPG7CpxKqi7PP83jjn7H3loQkJYwXLgINgJ9Hgsc
 H5iT_0fS8GBiyV1eZ6HnulOU2At33khhpc_NeMKk05m6J0K14ISZJmX9Q3PM4ucgc_ETlQceM9uq
 p.8IH2qud5NA0Cr4HtkMy7tLdMglU6.Hb0rF3f4zhCni.1IczLedCG5ZIp2kLgyzp.DtUPrwFfqW
 dlQzSM2VR6bgQOrqvdqUbpl.fNLeH4IR_kDVyqsDEeAdmKkxn0raLYZxa8qZvYSH4rr6RRS8HTRm
 WyqwbUj1hLdo_3CSwI_YByQjVQR___Vow0RRhZP34NRzivMkfKC5wi_TmqxVZASBQ8sZQfwdy7m_
 AhKgMpvVMvXdugQxEcXPMYvvq3B1oCG7kaLmjPW67Df69xXKjX7LW7mPqoXRvfFRQA4w6_UnkiA3
 7UY5slef6Dmqhi8aLB657nNOVh8axxg.Ku6Q4EEDR5cPRg3ngno4q44w2cgU35CalWlmunk1O2xJ
 sEi2Ex6L3XQDYIC98KPefJD2jwYtXLWK68Gvy53jTUxtLiiUB0VZCggRN77nMqvY1ReZHaDb0tBq
 rsMPAD1JEgexpp8N4t_wdlMJbanIlTfrkeJb5m0erbCy5wFoI1M2sumv0Ka2leXNpLQgNWmzJZNK
 qJAD3heFRR4hyfk8NxRGDOXOGphAPzW_G2N_jkqEVe9JDi2udZlzeQVHfGfr16gAFLpr8oBVzcbe
 iPAszg8CJjq72DAb4UGu8ypjURFUMyHB8HB5YrYqXjWez6Yg7abSVwgbjpi7coZEVjhDe.DjFIP0
 SRwqGcyshreT9LdiPtkf6e8_JQuoVpBYZfT2G3.0PWpoE6I9Hb8OLAanMWv0HLh6CybMRg9vMaUy
 GqpPYOhxcpbEq3oFKIz1ypgGldmWjOj1Y7rle71pMcRtA579JIGO_Dac-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 912cacaa-7b94-4262-9727-0b7723a8fd63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 Jul 2026 19:50:16 +0000
Received: by hermes--production-ir2-676cb4d88b-5gr6s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15052f7426db3f48268ff2a6d7865799;
          Sun, 26 Jul 2026 19:18:51 +0000 (UTC)
Message-ID: <2263dec9-67fe-4f0c-ad0a-82ab2a2661c1@yahoo.com>
Date: Sun, 26 Jul 2026 21:18:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: use
 devm_mutex_init
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/18/2026 7:59 AM, Luiz Angelo Daros de Luca wrote:
> mutex_destroy() is needed while debugging mutex. Instead of calling it
> directly on driver .remove(), just use devm.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 15 ++++++++++++---
>  drivers/net/dsa/realtek/rtl83xx.c        | 14 +++++++++++---
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 5ac091bf93c9..c787fdb75413 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -1988,16 +1988,19 @@ static void rtl8365mb_get_stats64(struct dsa_switch *ds, int port,
>  	spin_unlock(&p->stats_lock);
>  }
>  
> -static void rtl8365mb_stats_setup(struct realtek_priv *priv)
> +static int rtl8365mb_stats_setup(struct realtek_priv *priv)
>  {
>  	struct rtl8365mb *mb = priv->chip_data;
>  	struct dsa_switch *ds = &priv->ds;
>  	struct dsa_port *dp;
> +	int ret;
>  
>  	/* Per-chip global mutex to protect MIB counter access, since doing
>  	 * so requires accessing a series of registers in a particular order.
>  	 */
> -	mutex_init(&mb->mib_lock);
> +	ret = devm_mutex_init(priv->dev, &mb->mib_lock);
> +	if (ret)
> +		return ret;
>  
>  	dsa_switch_for_each_available_port(dp, ds) {
>  		struct rtl8365mb_port *p = &mb->ports[dp->index];
> @@ -2010,6 +2013,8 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
>  		 */
>  		INIT_DELAYED_WORK(&p->mib_work, rtl8365mb_stats_poll);
>  	}
> +
> +	return 0;
>  }
>  
>  static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
> @@ -2567,7 +2572,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	}
>  
>  	/* Start statistics counter polling */
> -	rtl8365mb_stats_setup(priv);
> +	ret = rtl8365mb_stats_setup(priv);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to setup stats\n");
> +		goto out_teardown_irq;
> +	}
>  
>  	return 0;
>  
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 90843d52c5a8..35df809a5951 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -156,9 +156,17 @@ rtl83xx_probe(struct device *dev,
>  	if (!priv)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mutex_init(&priv->map_lock);
> -	mutex_init(&priv->vlan_lock);
> -	mutex_init(&priv->l2_lock);
> +	ret = devm_mutex_init(dev, &priv->map_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_mutex_init(dev, &priv->vlan_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_mutex_init(dev, &priv->l2_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	rc.lock_arg = priv;
>  	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> 
> ---
> base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
> change-id: 20260718-realtek_mutext-41a072e5cd24
> 
> Best regards,
> --  
> Luiz Angelo Daros de Luca <luizluca@gmail.com>
> 
> 

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
