Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291D3370EC
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711203; cv=none; b=HXnzCSQbC6467JfuwS3LIHTzg3BQNMRDWTAOtvTIqG7ht2BmAEARoV0lsGaceiduD6Fw+XA5mqEMYQf+lXYXkH6YKj43d8sIoLYyI4APkHd9F53wsbeXZAE/GBuXmhquPF0wt2XoqWSTyg4Wvhn5lELAzWoTYWCifglbQkaKKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711203; c=relaxed/simple;
	bh=erNGYnW+PMv1Xj8MHnSbkXN0uJWL5EetewcbbmYBUlc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QS1UVs3jyg0ajQKP+F+M93DJxphCG0mS0ZvyNZX75ZZeyKeN2mO+vpHN/Bvf+mTTULq7Iobcc1J8EqhEfHco/6NnUaV5MqAUI0aI14qspLrJ0iGlQkP/ThkHytFUdLLGwZ6XRUDaPGb7YfoEetOQ/WCKJFMLqjwvUPOv3ybBhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=ECmGmx5j; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="ECmGmx5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1774711181;
	bh=erNGYnW+PMv1Xj8MHnSbkXN0uJWL5EetewcbbmYBUlc=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=ECmGmx5j/+LO5VCDJuTc7IpRuL1qCabEXknDMS7Gkx1AuPFpTGGl4AvgqtnzFp2gC
	 ei7Mg3T3CDphzK6wwVu0XO8BH+En6ZgxoLTsJiuZ5MgXfw6xXntdqeBitVDGZaG9Ki
	 fdA/Wv3SGo/eSI8ormm/t11kyJJ7KuXY1YegzRa0=
Received: from [192.168.178.180] (p5dc880d2.dip0.t-ipconnect.de [93.200.128.210])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62SFJdm2003458
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 16:19:39 +0100 (CET)
Message-ID: <02a713ac-f794-416f-9d69-95ea98d515b6@tu-dortmund.de>
Date: Sat, 28 Mar 2026 16:19:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hawk@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, j.koeppeler@tu-berlin.de, jhs@mojatatu.com,
        jiri@resnulli.us, kernel-team@cloudflare.com, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <20260324174719.1224337-7-hawk@kernel.org>
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260324174719.1224337-7-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, thanks for your work! I am really interested in this patchset.

I am planning to submit a similar patch set (see [1]) for the tun/tap
driver, where I am currently implementing qdisc backpressure similar
to that used in veth.

Can you run pktgen [2] to see if there is a regression?
I think that there might be a slowdown due to BQL not choosing a big
enough queue size.

Thanks!

[1] Link: https://lore.kernel.org/all/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
[2] Link: https://www.kernel.org/doc/html/latest/networking/pktgen.html
