Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185722;
	b=Rq2OPVTnS8g+LgaDjNfbm6uvy+odNuwAT6d/l1q63X+8UAWJeCtrs4qp+mIuIQYGI3zn
	 0SMI+mFAFbMYhyakkzoQGb+wO2PQlhFNboC/0WbmL3Z6GcotEOS5lIlVi/P1CMjkKCs+4
	 VMwJCGE524rT+CTGtzUnJznrYcztXO4euQmEJaZHgu6m0SiF6Xvm6pSY0lyDPihvOqGub
	 ySakh44JJHpDgkL3rjzyW9MaWvlXxVYp9s04BGPFtRjxL2cs8hMzZwvKbiHtV459eDTiz
	 cu+KLHdKxUjl9z9KO5XdKkmXQKyBViEEtCfjyKDi6aKCBDdHfwqfUFtytqDYg77rbhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185722;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=siORJd7LZwDgICSKGjyivx+vmAgZhVMEqu8f43biolo=;
	b=uyFW37pQuWJ/vt1bH7euu7w8vHmkwEMzILCyGEmmr8rDxMxltsUrxbndZFHjJofjH3nr
	 Ujp8ljgB4Jpox3goEeai6a8eUZYq2FG/vBCSEiMNdh+omE4xjClgC+EepZXga6SDABBuk
	 ECXgQb4OcfhJQfPVyIMGGvNqczs64MyXtMzL5Q9cw/Zlcf8Ykl+yO0qjgPqQs24Jy5aq/
	 0KEcWHa42afvU/b04VfSK+ZeYwiwdYjHJ7fOJSkT9zaV0mXYlQWOB8l6THEYmTkf+lmrq
	 zRgsYAuU0tjv8kuYwq035TfvyEy6pzosG/l5ULyKRzoYt7e/klmclla/R5ISIMYMiFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=jKNYHHxm;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD4606A31A;
	Wed, 28 Oct 2026 11:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=jKNYHHxm
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88AA3156FED;
	Wed, 28 Oct 2026 12:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793185718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=siORJd7LZwDgICSKGjyivx+vmAgZhVMEqu8f43biolo=;
	b=jKNYHHxmaC2APW0DVeupNPPz7wHexAQ7EnvAF8hRbuuPMiugJWw7ltkYK7lAd7fMF5mXyk
	pTIQZszFTsew90Dnnu+spQO5bb/5NHTB6MiWVz8Tq4FRygwp/GpnOsBAfyc4HNcAuxQWBE
	1M2zTnZgWI7NWzIKvSmzBeZbhngzRfS3CjU3B//8GhotEV+1J50qnp09KLvTUKGJmn97Gb
	zPVHK9KwXHVL4+JbRw1UJY3eQ4IQ6+Q/ruyqRsfWSZsfZFydkVAjKz3RiCbTMZFvAEQlxl
	ldUq5P1pCV9NStB6xLGl/eVM940SawUj4VDm7TaeL8IpFnitrgjDdp00bn0Ujg==
Message-ID: <18472c61-efe2-4529-971b-82d877df6b15@cjdns.fr>
Date: Wed, 28 Oct 2026 12:08:29 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, linux@armlinux.org.uk, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
 <734d4f06-26af-4bea-9c83-eb92c1b3b894@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <734d4f06-26af-4bea-9c83-eb92c1b3b894@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Thanks for the review.


On 28/10/2026 03:15, Andrew Lunn wrote:
>> @@ -199,6 +199,9 @@ static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
>>   	u32 val;
>>   	int ret;
>>   
>> +	if (priv->is_passthrough)
>> +		return;
>> +
>>   	mutex_lock(&priv->reg_mutex);
>>   
>>   	/* Flush all non-static MAC address entries */
>> @@ -970,6 +973,9 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
>>   	unsigned int age_count;
>>   	unsigned int age_unit;
>>   
>> +	if (priv->is_passthrough)
>> +		return 0;
>> +
>> @@ -1386,11 +1446,14 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>>   	int length;
>>   	u32 val;
>>   
>> +	if (priv->is_passthrough)
>> +		return 0;
>> +
> What is actually left?


In v2 I was using special switch ops, and it looked like this:


/* No manipulation of forwarding rules allowed in passthrough mode */
static const struct dsa_switch_ops mt7530_passthrough_switch_ops = {
        .get_tag_protocol       = mtk_get_tag_protocol,
        .setup                  = mt753x_setup,
        .teardown               = mt753x_teardown,
        .preferred_default_local_cpu_port = 
mt753x_preferred_default_local_cpu_port,
        .get_strings            = mt7530_get_strings,
        .get_ethtool_stats      = mt7530_get_ethtool_stats,
        .get_sset_count         = mt7530_get_sset_count,
        .get_eth_mac_stats      = mt7530_get_eth_mac_stats,
        .get_rmon_stats         = mt7530_get_rmon_stats,
        .get_eth_ctrl_stats     = mt7530_get_eth_ctrl_stats,
        .get_stats64            = mt7530_get_stats64,
        .port_enable            = mt7530_port_enable,
        .port_disable           = mt7530_port_disable,
        .phylink_get_caps       = mt753x_phylink_get_caps,
        .support_eee            = dsa_supports_eee,
        .set_mac_eee            = mt753x_set_mac_eee,
        .conduit_state_change   = mt753x_conduit_state_change,
};


>
> Is there sufficient code reuse that this makes sense?
>
> Would it be simpler to have a much simpler DSA driver just for pass
> through? Or the mt7530 driver has a second dsa_switch_ops instance
> with all these functions set to NULL?


After sending v2, I discovered that some switch config runs across the 
whole switch tree, and NULL configurators causes those ops to log an 
error and exit early.


As far as making a "passthrough driver", there are a few things going 
against it. As you can see there is still quite a bit of shared code, 
also it would be inconvenient to use a different compatible because some 
chip packages exclude the MCM switch and have 3x 10/100 ports and 1x 
gigabit port, so its better for the DT to pretend that the mt7530 can 
simply do full hierarchies, though (per the big commit message) that 
doesn't actually work and we're relying on the fact that hardware 
integrators will not require something that can't be done.

Lastly, the TRGMII calibration requires poking registers on one switch 
and reading values off the other (patch 7) so I think that mess is best 
kept all inside of one C file.


Thanks,

Caleb


>
>       Andrew
