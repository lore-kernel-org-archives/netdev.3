Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D03F5BE6
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466902; cv=none; b=QQcYOMaui2DgYxV3uRlFeDxfZBZi52zLM3m9YvTwa9JPLJHBkkluZd2M9ZPM5J6ExMv42Mz+TVF/JSYm3s+Kp796qckehEfiaNeVODWTfCeegum94otjCuZoFU5BkXYJJ8c3/eXvlj9fLZw9V0igrb9G/4j1fZfTdn+LRwZkHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466902; c=relaxed/simple;
	bh=r+2I1mt5JUAQH2DibPBlj1jWA1g+boPLEamUKs/RTlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/uQSyUWyZuTOl4kPbftz8/igj3hVkbVfe1IlR9SHbJsd7TW4sdr+vPjY3H+k+IMnhLDiTcLg2MVh+yBPAZ4sd0OJElLzbMIEjQPZu+um4y3lyNM6OqdIlSUPQvXF8BhNMjJ/zEKxBFrlWVyq5BxxFj/+QOm9gfIwKjckpXVXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJXZ2TGT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEGTLxPN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJXZ2TGT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEGTLxPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789466899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/ooFyjMzxLyQ/E6w/+gsTRY1i8Gt2eVZp+CjucjAlk=;
	b=SJXZ2TGTpAQ3qXcLE/ya8zpdhDDMr9a7bQgNCWkmtujXE6oXKlMk0ieKGpnK5RrqK2RqaD
	URKqSqeBUjTnPXeQSAPUUe5SyIm1BIwYMwqldEqp4G76fcVXyyrxWsqbpHyZLTb2EcGE9J
	I0XAGFy6ZGfGWm37wy5xjWMiZ5tyVO4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-v-KSBuAbOHOIs99JyQnVZA-1; Tue, 15 Sep 2026 06:08:18 -0400
X-MC-Unique: v-KSBuAbOHOIs99JyQnVZA-1
X-Mimecast-MFC-AGG-ID: v-KSBuAbOHOIs99JyQnVZA_1789466897
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870663a5c4so285825f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789466897; x=1790071697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/ooFyjMzxLyQ/E6w/+gsTRY1i8Gt2eVZp+CjucjAlk=;
        b=cEGTLxPN8MR39DbJ4GGo8Ys5W8TUXof2At9j46P9+UzDcB0RpGJVPONPnOl1mxk8Vw
         hgNvSK0RfpQCVSASfoBBM6clvFcrLaTltJD7j8Ky+atBW+i3dOnZcmjDnZ08TYOPRiE+
         bwlkmvKWxPlXKvWH0iTi6Bd4vEgIVPhS2nGfldSXrMtPbkz1wIretUyML2l1L1GzAXD3
         Jc5gB8yPNvh1bz8Pu0tYpyS/xJGdVHnBEjqX+zIBV2OMd0vWoF47YSAqkQM+OUAKE3kn
         ayePaGManzOrRddL71UzqeLTHtlPAgg2U9tbwNFB76E/+fFBSrf0Ypc4kKuiMsiucu4J
         o8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789466897; x=1790071697;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/ooFyjMzxLyQ/E6w/+gsTRY1i8Gt2eVZp+CjucjAlk=;
        b=aNtVrFv3RkRUR7uuNTzSLJJ4wvKA1Vt72Ryc8AdKXcJ3g1qvVS8D+RTf03GMngPbLF
         krYN0MaBjkPjqRISHKsuIZR1c0Ina7VV/kPF3A46ermPNe0bjMZWF1uvH4svPSjLN27L
         6J595ql8YcN70BIvgN0v8KmTT0H2p5CtzDqApMI3avNAQI2XCVQw+cVkYnFtCWzm1Y6f
         7mlWQAZw/yX4fib5S/osczHtO6GtXx0oKLDDmN1sJ4FrxkJD/hcPoYhVvsaZXhDdCOwU
         iMXY7uAk3rOYPxqiHl3FlytzSuv1XJpx+/JnhQz5EpiFAW+5WWnkz1M/EJOfRf5k/3BI
         qieQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwBy2Snbc2JJ41ARMxY4OXCfX2CJIMLsBrgdL59wdWS5snps0nZPxGGSE2k88hgjIDqPJHmmg=@vger.kernel.org
X-Gm-Message-State: AFuF++mNwo5o2lP3lPxQjTO13R266oq2rpNtu4OHHtnZodtHEeLzIViW
	6FqRB+CjV2Mb9B+Md5rasSo+oqphyCJ/7kY+64Gt6s+AmOWiZpVXhis3t8hmA0gsTUQ4Uzz3CwN
	NEkA3Tm5W3C3t8kG68zPlOl8kojih8uOwYmB7U6z4YOd0isPcnsJc6KLvpg==
X-Gm-Gg: AYBFou1z6UX/VbeU3P0CuGUQyIb2bGBS+dow6SYWByagCsMJfyNrV8B6CkeAc6syGoX
	SxQ8FRCq4nfqiT5Jre8KsEfjLoclifZn+tyAMUmUlSO0d5T8x6g5ol5vrncFXDgBkUaM4h7laAi
	XGTo7weLkmGUaGjqnvP/vmZaFi0e+bz6TmE4OzvEPtPdODRbhodSJD1c+2vJZQmrCRkqpcUNLIu
	Z61TcWKuvxPwLO+LnbLtHpkOxwyOikGpmNqSvS1e7DDa8LzlTcZ944YZDLv1gFiBMnR14/ZjUlR
	1vQXq/GnvIrcOZE30MAvDcsXPLjtyfrqENWZsZdwgyrkAmTbLgPS3tD/reJrxydd+BwQ5JP2jVr
	Sm810y85nmomnlCt1ebUeS0djxdXQPn1abRw+3jhZ4ynEpxnUgT2bTqd5CEdrSDuGPeE4vClZ3w
	==
X-Received: by 2002:a05:6000:41f1:b0:484:4880:449d with SMTP id ffacd0b85a97d-4870a951e92mr85711f8f.3.1789466896821;
        Tue, 15 Sep 2026 03:08:16 -0700 (PDT)
X-Received: by 2002:a05:6000:41f1:b0:484:4880:449d with SMTP id ffacd0b85a97d-4870a951e92mr85662f8f.3.1789466896304;
        Tue, 15 Sep 2026 03:08:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e81asm35564685f8f.7.2026.09.15.03.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:08:15 -0700 (PDT)
Message-ID: <3eb68f01-a932-4a29-986b-b506ec6adb95@redhat.com>
Date: Tue, 15 Sep 2026 12:08:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk
Cc: wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 12:07 PM, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This series enhances SR-IOV support for ENETC v1 and adds VF support
> for ENETC v4. For ENETC v1, the trusted VF management and per-VF
> configuration query via ndo_get_vf_config() are added. For ENETC v4,
> preliminary VF support is introduced for i.MX94 and i.MX95 platforms.
> 
> On the PF side, the series introduces trust level management and MAC
> address assignment for VFs, and implements ndo_get_vf_config() so that
> userspace tools such as 'ip link show' can query the current per-VF
> configuration. The PSI-to-VSI messaging infrastructure is extended to
> handle link status and link speed queries from VFs, enabling DPDK-owned
> VFs to obtain accurate link information from the PF.
> 
> On the VF side, MAC address filtering is implemented via the VSI-to-PSI
> mailbox, supporting both unicast/multicast hash filters and promiscuous
> mode control. Since the ndo_set_rx_mode callback is invoked with BH
> disabled and is incompatible with the mailbox polling path,
> ndo_set_rx_mode_async is used instead. Link status notifications are also
> supported: the VF registers with the PF and receives PSI-to-VSI messages
> on every PF link transition, keeping the VF carrier state in sync without
> polling.
> 
> VF Function Level Reset is handled explicitly to restore the PF-managed
> MAC promiscuous policy after each reset, since the hardware default after
> FLR enables promiscuous mode regardless of the policy set by the PF
> driver.
> 
> Several preparatory refactors are included to share infrastructure
> between the PF and VF drivers, such as moving msg_task and mac_filter
> from struct enetc_pf into the common struct enetc_si.
Most of clashiko feedback is around the consequence of the 200ms latency
introduced by link state notification. Given your replies I understand is
a well understood compromise/design decision.

I think the better option is merge the series as-is and eventually
follow-up as need would arise.

/P

