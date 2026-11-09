Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187680;
	b=tO+ttvLSsvbBQQcM5EAOecD+NdP0AkqvAK8cp1PJWIeOmUhwqBTWJh8Zxx4cXxe1b4+h
	 wiUBjUK+ekWi6MPGX5QdZN2f1VBNSPNaQq0DRFtFkgcQ/XEsOOiUNtyIlr8LhckT5OL1r
	 3RY6204nqO2oSmuF/9hV8XSMlaPSFJX2m0GRF2XtkTjWTqpG8yCHZAG68PAZX6KTaahEO
	 KSPHP7q51ImHkZT+WN9V6v4EmB8WT2MnnJ9vF6CpBEaZ2qqUjUeWr+QmpGFlqFK2rM9Xp
	 NGKCRb0mZUzP17ph49kWp/bokN1Oax6p1vZgxL4j35XG+OFg7Vs85TCu8ECKZhQSl2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187680;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UTLSOj7c/921RgOufTYQoPSv/inK1u3+xSiJXgbSXIU=;
	b=Mf6xv57WK2Hgi2tZIizrSflj85z2xda5+2YoNZsG1/YOc4UAFE8L1hxOB6/87Z0R2ZxO
	 ZJMDsg+C1mrjeKLIfw9R4ZYoJXxqLLZqAh52+WD65gSiXOYx5HtpqfVPxA2FZV5y4dH7n
	 hLv/X5YpMFy6mO6A9D4hp9bSOsrMuY4wRithG5tjGPBtfzUjHJNrhaEVKNiU4HTq99h1B
	 zB0WVa4xctuREIvb9lUj4WJqBHhSD86ajTFbi1Xoa8tYndMyOpcsUlFgOclN5S4E2EOkv
	 VyqtUnMWfLsu+Bja8eQrqMZLW4KvxmlBaTfHByMce22vE1Wn3gO23eegBsYZ5FaJJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE1606CCD8
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ACE1606CCD8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5ccb3e0dbdc11f19a56ed5b684f684d-20261109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:921cb9f7-9078-4609-ac36-2e6a2e8002a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:615c50c0eabf648503306c80c275113c,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c5ccb3e0dbdc11f19a56ed5b684f684d-20261109
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 418288846; Mon, 09 Nov 2026 09:27:48 +0800
Message-ID: <b4a8bd7d-bb8a-4058-860b-31001ea71d9c@kylinos.cn>
Date: Mon, 9 Nov 2026 09:27:45 +0800
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
Subject: Re: [PATCH net v9 0/2] tun: fix re-attaching the socket filter
To: Jakub Kicinski <kuba@kernel.org>, Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net
References: <20261030060043.94719-1-clementwei90@163.com>
 <20261106124520.0af39146@kernel.org>
Content-Language: en-US
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <20261106124520.0af39146@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Jakub Kicinski wrote:
> On Fri, 30 Oct 2026 14:00:41 +0800 Rongguang Wei wrote:
>> This is v9 of the series that fixes attaching a queue to a TAP device which
>> re-installs the socket filter of a persistent device.
> 
> This really needs to CC bpf@ before we apply it. Please repost.

Sorry about that. I'll repost with bpf@.
