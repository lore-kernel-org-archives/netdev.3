Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450889;
	b=2R/7zwnDkIJPXy9e9oH+2U1ZZ0lrNaKvVMDyF3B7usOFnmTyIsbDOIeDNiyROiGgKHnT
	 vhMB/HciOUFYeK7R5D96oCTTHLXAMjaQMIhlrEM7nfw6NK22xTxJEsl/f0Ub1LVqhs9WL
	 QeLWxdaGs9jsxkVTHymKZL7LJCPdTpUvEpG1HqxvFNPohB+jcUgsoRoCxaO1O9ZuO27E6
	 IAix4VnZPZGncz0Ec2Oa89zHNVUL3mtKwN0BWhkoTt6EtBnEzxJfMiRz8tn3dXXBAWFrt
	 sgx4FXUXusCXUn8BBKG1ngaEAfOxF8MD3nWB3pRfrWX5ML9F90bDhEIgO4nv29Ou+gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450889;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=emO6sEIDSkEFWkAyFtAW5uo9IdZWrTOY02AsTAB3ghg=;
	b=t2sm649qCP8a65HZQSP4WFIMQVDI5kfqtedGLlXYXuhG1PGOjTU9YLQoYUvFqJUq7C3J
	 hiAB2enwPdcKd4ZtkVScYew85AP/hbhfFu+tki+nCqmEoZzUO8QADvc2i/Wl3V8nQ08Xx
	 WuI4ppNgNDsVtU/LFJRfczpMkPDfmjTi7cpPNni2cUYBBjPrJMG2TywVbIsTtHd9VV+6m
	 W+cBl+LkcScxrSrzwApBWxZEoRYsqy5LqXSBwyIQxkm4ph8w7br8hj262oc8PJk8wJBHy
	 cvlYljtmqm0fNA/5Mx/5S52rM/R691FilUPeqAI9ttRBycftVdrdM6gQ4eVBbm5wsTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=r-sc.ca;
	spf=pass smtp.mailfrom=r-sc.ca;
	dkim=pass header.d=r-sc.ca header.i=@r-sc.ca header.a=rsa-sha256 header.s=spacemail header.b=kbEdxGlY;
	arc=none smtp.remote-ip=198.177.127.194
Received: from out-utut-a194.jellyfish.systems (out-utut-a194.jellyfish.systems [198.177.127.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8D606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C8D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=r-sc.ca header.i=@r-sc.ca header.a=rsa-sha256 header.s=spacemail header.b=kbEdxGlY
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j7rcq5L1Gz8sWN;
	Mon, 19 Oct 2026 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792450860;
	bh=emO6sEIDSkEFWkAyFtAW5uo9IdZWrTOY02AsTAB3ghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbEdxGlY9Nlbf4rp/11jWG32FqrEyxlFiYY1zJbOTD/+utKtaYNDlVzg8jgCqtgGB
	 6K4uPO4SeNrtk47TN8NZzN8CUIGZKuZ8PNrGlGG9EtmYXQ/3Ezn7HPZGci8vPK+nhz
	 MDLzYkXQF94JKsOnSSYNr+d+5Nn9aGpEOXEi3f6d2MqQDKNdPUf0BAagTYLlubK9PJ
	 N+3fcNxexu0Cpb8BMKcdgQEgx34J17WYCDxL/F2DMviO6MtbsMGnGVSD/Pjp4fl8Xf
	 2Yjs/X7Aq2YkRdLI7I90SEVWbubj0grzDbgIxEx7TUwXB/fG2FmNLhAtxyFUcPnvrE
	 VkzOWlCdLUjzQ==
From: Ross Cawston <ross@r-sc.ca>
To: markus.stockhausen@gmx.de,
	andrew@lunn.ch
Cc: lee@kernel.org,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: Re: [PATCH 0/3] leds: add Realtek RTL9300 port LEDs under software control
Date: Mon, 19 Oct 2026 16:00:53 -0700
Message-ID: <20261019230053.503-1-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <010701dd5f94$d636ff70$82a4fe50$@gmx.de>
References: <20261018194339.132-1-ross@r-sc.ca> <59f75e7d-9b56-441d-a4b5-58ad3862267e@lunn.ch> <20261018232015.527-1-ross@r-sc.ca> <38ca5375-ecea-4361-ab26-c044f38ceadb@lunn.ch> <20261019054233.1884-1-ross@r-sc.ca> <010701dd5f94$d636ff70$82a4fe50$@gmx.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

On Mon, Oct 19, 2026 at 08:41 AM +0200, Markus Stockhausen wrote:
> [...] it is currently beyond the time available.

Thanks Markus, that answers it.

Then please drop this series. The PoE LEDs of this board go to OpenWrt
with openwrt/openwrt#25341 for now, and I'll come back to the port LEDs,
in the port nodes, once there is an RTL930x switch driver upstream.

Ross
