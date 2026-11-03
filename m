Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698009;
	b=ROFnQ6bIHAYIkyhIaZyDud6ZpN9EZWFEqpOyKDM9/FDTUvcfEMzmKK+0QUEYSPHq0DWH
	 fYgiNr7FOvIdZ+XNHeFexG7aSIqAlBS1VLa0HXF6lUOX9LPR9UERBcM1C87clGo+/ll+H
	 w5IVq57rFwAsm57hXmHCU2eyJwgVxaYODr69KH6nDqNjtNbNGrvQ7hse3CsZam+AFREu1
	 AcG/AYyvNDXbY5nf4Cxgc1CfPN8ajprNGPrlFu8tYXhEfV3TXZUlM1DTAVS0hSKagr375
	 vNwQP/P1lGassWdHCcthe+AFMP7xYJA2i3DAkL/w3BEEJFJlGGCTfYyek5tNtk+NHng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698009;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=TX0r1A49joVg+tee/dzPMOSDz/uT8G1cg7mVYx2cegM=;
	b=x0D6f/p6GSDC/KmnoYn2dJ5LwlhVAgy0tJxPap8G9YRRmaLb6ZEdGVUXgIA7nZqD9DuK
	 PhoFaj/xsTvg0IoBKWcJC1KqXnbLNY+KwRTm8FNDGWDBbw7QGdqeBvo0qMhkt3uApBeR5
	 6y+/Y4X1RLo1KvH1rD/9J74WDip+byHjmIf8DNoXWRb9nW5Qe7VuUzK+iVdJYWNaTuhkC
	 l9T/V3B8ApQAj7MnseJuxwKPVU/reXASuWLEaIBL8YUEyPHHRjPe7+lPfWpSK2FMb2t+v
	 JCjKJxEB6vzth/IYVCtXDLUvR96DyQcuB7YmX7Rpoqa0H3/pu8TB5UGHkGmBJUSPxng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=M639CzfH;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA3606A326;
	Tue,  3 Nov 2026 09:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CAA3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=M639CzfH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793697989; x=1794302789; i=markus.elfring@web.de;
	bh=TX0r1A49joVg+tee/dzPMOSDz/uT8G1cg7mVYx2cegM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M639CzfHdOeMsL7Z20Bqvw269ogPmc+G/yfqTpVMxkaOOcxlot0+sIHEdjZG01mW
	 rQcjDzYWKKcqBJL/byfJZS0UO6uSts9+G2GmvHmBBwCzbaxNcwRn+XptPPjA7nRVT
	 FciJZ8ieHiLNuAELWwqn2EeI5cWqxGR0JPA9YBw4ZuOOkuSYrhEM1GQcLJmpzGraD
	 VdWSn+bvjFYDm4grwvzRZZ8iChOqdRvrYFqTI6q4gK2zcJ5qCcZIg4dOxnGykDbQG
	 8sVCYFpq1Zi4mX4Yu5Rhv5AaT6cjcQRJzju6BIBVI3/qRm9a5CD9gg2aBakSVDv4A
	 WNS1f1RuOX6aSOvzcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1ww9WQ2Dog-00ND5Q; Tue, 03
 Nov 2026 10:26:28 +0100
Message-ID: <225a66e4-e1a7-422b-8546-5cf7a027e063@web.de>
Date: Tue, 3 Nov 2026 10:26:21 +0100
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
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20261102215806.13723-1-rosenp@gmail.com>
Subject: Re: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261102215806.13723-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LaIKLJ61CVd1RwlgA3ym3G5DGamcWMVT0WCya5Gx3s8xy0jj6C
 lh+iwQlAzOc0AXklvbbyaO5yUCuz4R25AxUi9OXBrkVsHNbGhx9OJeeDKZUwDJz6jXQYIvz
 7oXR8S7BiDQ5jQVej630HEqW/YTGmI9/iSbSVyUcW+Fp4hU775OKPYyJE+rsLcjhVhAPOXw
 52OXKedWPKAH0wKfKFPyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VNvdw//uecU=;Xgq1V2lpBoi5bhA10deD3l2KMUQ
 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
 NdOQAmnwSYbd1V2WM39/Y4iJ4215w14=

=E2=80=A6
> Remove the feature flags and the fallback. The stack then computes the
> checksum before handing the skb to the driver.
=E2=80=A6

How can a =E2=80=9Cstack=E2=80=9D compute anything?

Regards,
Markus
