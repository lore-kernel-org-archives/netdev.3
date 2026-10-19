Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439779;
	b=wKo2zx/6bGxs3KAGKyR2g9rDoNeNi6dJNSdw8Dw93jWLiJK9Wg8YDYCSc1ibEDsyvJS8
	 sQ7jymydxu4ehNznjk2MlLfdM8/ExVryUuDXsHTX4P9AuAFQmoNAvhCUhGJqN1ffj9yzE
	 5rOBdq9W4ZIXAJw0rileMP3b1+maO5SFju4gGVhhiKpo4V8p03MWctAmraLJwEA6uwxIJ
	 MG7+aKq/U3Ii1VxozScZD5EeJIiTIqlt0GtTLufIe/g55I1L49lPWwiUXZHgkURODemGW
	 yNs0jeSgJceMwlzhD+H/1oTgPhD9pzVRr9B+NqmRgMhoRB0j3OuhUJlvZvSrGwqcEUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2tfx55cbh2+o1RBczj7C3GIjCQ6GhLZwos9LV25fzdU=;
	b=boocDBsoHyeVrGUWzMfS92b7kP0PIe/g6TLptiRtutAwtfQKzW13K9HaDOoe955hCM5y
	 antDTRmtei65Mz0uoMv9EfDGeoRHzzvUADUgfIdImM/O2Uxkfgpc8YDytTx52lPvhPt9r
	 b29/hmCUaMiXkiQqnLm715e9mVHAEXsmf2E1of+6Np1b3vtfh02N0p2iop/6pMlCQSoV3
	 boonzqiwgDdGzBsJ/ZRpUAHmQ0NYJSWupdupxmFLeSD8QD8FB5neaXW58+LZUUqO5RY8t
	 /UppjIcfBGC8fmC6alHMSHQ8X/G14N7op2qQiuPyCzflNk6xLoq6U0c9z8JFKa0IIwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=N4bs4z7v;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BF606A328;
	Mon, 19 Oct 2026 19:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D7BF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=N4bs4z7v
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id ADFE4E83A99;
	Mon, 19 Oct 2026 21:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tfx55cbh2+o1RBczj7C3GIjCQ6GhLZwos9LV25fzdU=;
	b=N4bs4z7vPu25vtr60ZvN2PTvChq6M07nhKxeQ4uSXpCXes7k4XnWwV3wmP+EaKLhukFUeA
	xXGk1B6tTuuAjzNOIH3FyFPaLNj7TI0biqvmglYef1goibG06nAHhDuwadOrS3t2Qn17fx
	3fbKBU73Opu3lutKYbwl3oLO2kvfh6M+3u3+OJYsfpvkDol5F3VYAvDioBvSKoO8AChqYs
	AmcsXT8OuXztcPWz8THQ9PhNqRzsrGqU4yHhXLuwlD6lvhRXcDy/dCjOOUhxPLvc1seCav
	1CrRNoTSolyiYJIfEiqc0/w6QmpWQ/sXjhT4qHVY6GWoEyt9jJasTJBZwiwPeQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id d3Vb2J8m1EdO; Mon, 19 Oct 2026 21:56:17 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:17 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 02/10] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Mon, 19 Oct 2026 21:56:15 +0200
Message-ID: <20261019195615.307912-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f80f6620-e0dd-4e1d-9fab-c15725c14ec0@bootlin.com>
References: <f80f6620-e0dd-4e1d-9fab-c15725c14ec0@bootlin.com>
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

On Mon, 19 Oct 2026 11:31:12 +0200, Kory Maincent wrote:
> As spotted by sashiko you can remove the two checks on
> pi_get_admin_state callback as it is already done in the
> pse_controller_register() function.
> Maybe you can do it in a patch before this one even if it is not a fix.

Hi Kory,

Will do. In the next version a patch before this one removes both
checks, in pse_control_get_internal() and pse_pi_is_enabled(). This
patch then only fixes the pse_pi_is_hw_enabled() error path.

pw-bot: cr

Carlo
