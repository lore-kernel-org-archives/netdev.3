Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898546;
	b=eFH03rMKO6sOreNyuBtzzzTnVEDjUThT4AHqjRSlVP9u6LtOkFc0TgjX8y+UY3KO5jqM
	 WhxnDgB/K1m6vmjnU2Z6Ogc5me6H94rz0DMcEMaZnOk/fr+iTk3apgSuTz6FiiKVitoeB
	 3riL8dCXUNJ2lU5kT1yY2RHtd9hqsOSLtKBIvZQokFHs621DGXE/Ij7h8UisIGXpf+aU0
	 V0bzukiYfLmXzqQMTxHKqqYlA274stmYnUkyrLwqVjnmrpwTArwQ+DyDs3ZWcaLjkom68
	 gUDiXAzHTKaXBO4ATXNaoEgHJVaPrMlHZbc7vDDlZAuriJ3reJxxpDbYgdrfsPtcNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=E6BV30veFVp7vAa8zjNCmhugAJtv5Cf8HFJzEFbMAY4=;
	b=J7TtJLjpG70DW0wLmNYm7UN2x6P6Oa8+1Cfju9N8rIkvWyIoCf2hx6HJo6VQW8BUBIDt
	 Wq74Kb0rm9zAnAqF40IF4wvK7mcayQBxzsiEeOVWqPF1s78XAEGkreIfBa/1HN0JcPEgj
	 fxGp+vwOIZPjzWNLu3Ki24rPPswjZuNO/hV4qz2vFqmQE5yQ7t3jtEoHwKkOlBBZeJUyl
	 b6zYOpArm6u5w3Yx7GtKdphqjzj6oqFT02g5TCNp6h9VGLRsMLVKQTrQ3UYv/TA2sx39W
	 LFO5xTQNE4A4OhhjSy3yZ7lBpUI95tlX2RRWL2sEIUPqKpMRr+J2O5PhsgSIpiRpEiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvNZZl8D;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E6606A32E
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964E6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvNZZl8D
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso4026369eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898546; x=1794503346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6BV30veFVp7vAa8zjNCmhugAJtv5Cf8HFJzEFbMAY4=;
        b=DvNZZl8DHCM+t5QbEFLP8gJaxizCxoWDmQWhhJ0985oCei1Da1pacOVjUKDHORo/JC
         RTK8t5FgZTvNe65/3QVQRkC7D+Keowo/BjFxUfMLX3wHJEVyMbX7QU3eFyUYsE5hTEZw
         HuAgZ+hsgOz/Qtzwl2CJeRRM8I1EAN3owgyByAq5pv1U/R+vPbnxuCpKRH0WK+MXaPjx
         f8dcE7tkrP5DS/iyddaQwLxtoZ0HTzOZrquiAKhEcRzolib5NR0fGXM8XC2YOwv5NaDI
         aJl92R6UWmdGpAIRgV5Js3QSPvJjbq+neD8w4xw9f+rvRaCJZjONRXLFJKa2LwKNqJPA
         /9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898546; x=1794503346;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6BV30veFVp7vAa8zjNCmhugAJtv5Cf8HFJzEFbMAY4=;
        b=ULv8HcoLKegoRKYQYwHuYpYPrSzblkTxj5z1H0zyRGRKTPVUZGtGWfpwSl+peQ9eb7
         Q4HzIsA0fnhZ+IBIG3QBHEoIG48Es7wB+d2ohq5i0xbyxG3s8Cg4bIbKwAKeJAelSdMk
         rSzp0rSU1FrrH+u2sXWwqn1iAWGe+Iba3wY6sJWv1SsVuqTojFRIUA6GMiXYE2kM1Rgm
         sSsBJ6s0BXOzjLr8O+OVjrS2nVcoIH2kfAeu31fe7tj6uj7BdczQR5RSyT3PbpN8NG1l
         moBDZRj4e8WTPjfQ9oYL6ckzpIVU4bg5JA6HT+jY/mKHcJssXjgNV2w3c+4rZ8qwVSHo
         /IjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAme36j5TuF2w4CC5fonSPhoNvOWO0YcbcXScurW+SkV3p59mE2qFlkpgrAi09M7LeKS80Ap4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zweSg1LDrpFCY33dukJfgs8okEFeYOxqRVXNkeKLncdB9iMwn
	BtGj/70H+XVASFuqHoTrosJfArtM1s3FIm++TrGFfqVw10xwll0Ev8D5
X-Gm-Gg: AYBFou0+rimCwnmiogJ4sEXJqcYMoPkV6nZ/738VImqPudqi5kk/LH8inmox5+rGtfg
	7y4YvQMMN35ZJxzSPqJycJByaMFugS9QIoTjEgKZwE7d4YzGJUOAcxFUlyU79YBTJH1f5xBwnfF
	dylZgNVwi8iyJW0VHfxEhoL9fcfRSgFw8fOg2/pbHDdX5FRtjboLmr4Z4iW+jdgDfwfVLDb1wCu
	cguMqXvVnst/VyPdc0nE3P0XQt6YFczCO1BCCLJ08Zcf/9oaMI3VZIuDwO0bO/Mp0saZJLT8Pry
	tIilK9GKkXRse0A2amh3JsKgnTdS4BF5gC38R2PWECJNTAdLPwN/7dzxV3mOy1YQh1FxeBaGuQN
	70Eaj2DVkLLXqf6eO15cJH/DFLpp/NRDKvIVW3vH/qgdDEEGuumqbkQqkqoBPuiJ7c3L6jjCVSi
	0swUI5fBh4RnpXkbgWaZO6N3SWFs4UCuhOINVUCFMOqlU1h/GpBrZYd/xcshXk0wzS8Zz9fcwQL
	SK+TYsoCrTHxjJJyApxE4SHhosBCYGzo1fM2k9+kzT/8gcXZRv5soh6j8XJ+6PQQtIkldrHXsuV
	PCF89Mf7vCGC6pgyp2PQKKQhsVShv279OlcfNrFY8VEf4zY20hm5a6gKoXDFVAVE9Q==
X-Received: by 2002:a05:7301:4306:b0:369:44b3:99c0 with SMTP id 5a478bee46e88-36a42340c9bmr28415945eec.8.1793898545495;
        Thu, 05 Nov 2026 09:09:05 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1368? ([2620:10d:c090:400::5:f848])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca394f297sm20589091eec.21.2026.11.05.09.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 09:09:05 -0800 (PST)
Message-ID: <619a4027-0709-4b13-9367-866a06d2cd02@gmail.com>
Date: Thu, 5 Nov 2026 09:09:03 -0800
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
Subject: Re: [PATCH net-next v3 4/5] net: sparx5: Add hardware programming for
 the port policer
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com
Cc: robert.marko@sartura.hr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
 <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-4-b45a3a26bed5@microchip.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-4-b45a3a26bed5@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



> +int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct flow_action_police *police = &entry->port_policer.police;
> +	struct sparx5_port *port = entry->port;
> +	struct sparx5 *sparx5 = port->sparx5;
> +	struct sparx5_policer pol = { 0 };
> +	int idx, err;
> +
> +	if (!entry->ingress) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer is not supported on egress");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (entry->port->tc.ingress_block_shared) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer is not supported on shared ingress blocks");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->exceed.act_id != FLOW_ACTION_DROP) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->notexceed.act_id != FLOW_ACTION_PIPE &&
> +	    police->notexceed.act_id != FLOW_ACTION_ACCEPT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->peakrate_bytes_ps || police->avrate ||
> +	    police->overhead) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->rate_pkt_ps) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}

Curious if we can have distinct messages for several unrelated checks 
sharing the extack "Policer parameters are not supported";

> +
> +	if (!police->rate_bytes_ps) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer requires a rate");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->burst > ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0 *
> +			    SPX5_POLICER_BYTE_BURST_UNIT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (police->rate_bytes_ps >
> +	    div_u64((u64)ANA_AC_POL_PORT_RATE_CFG_PORT_RATE *
> +		    SPX5_POLICER_RATE_UNIT, BITS_PER_BYTE)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	idx = sparx5_alloc_port_policer_idx(port, entry->cookie);
> +	if (idx < 0) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only one port policer per port is supported");
> +		return idx;
> +	}
> +

Any reason why police->mtu isn't checked? In software, frames longer 
than the police MTU always take the exceed action. Is this intentionally 
skipped here?

> +	pol.type = SPX5_POL_PORT;
> +	pol.rate = police->rate_bytes_ps * BITS_PER_BYTE;
> +	pol.burst = police->burst;
> +	pol.idx = port->portno * SPX5_POLICERS_PER_PORT + idx;
> +
> +	sparx5_init_port_policer_stats(port, idx);
> +
> +	err = sparx5_policer_conf_set(sparx5, &pol);
> +	if (err)
> +		return err;
> +
> +	port->tc.port_policer[idx].policer = entry->cookie;
> +
> +	return 0;
> +}
> +

