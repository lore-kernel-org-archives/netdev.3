Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132693FE344;
	Thu, 11 Jun 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183440; cv=none; b=ORU0fr3IIYqbnO/pUJU0mqmXsuK0ELz/zL2e7s8jlOAtRBF+LK7YfrX5rmwa1ldcJDE9jsANR3QMKWGmMDL2e2GtDiRCSAa+i/OhfZzSQ6yPFhfC4SkOkfYxfXK8f8oiRDpTzIoRssZHcU+3Fr6iKkwP2Y4/8ceVUeDSPPImzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183440; c=relaxed/simple;
	bh=UbPVOhpxd+byepTOQp1HKl+PdgCM/QXBN3qQgTQEYFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYMh2NHa2KTXZM3eXJQ5ALi0fxjREjdeBNIiswXG988zXhaUgNwsVjWtT95+HzSZTtz8uBS/n3utvFYnKoHHFdOu15w6BcCRFvMMalHpaHIim6og2LMcytrLgG3skRUie7OU4fBF0swh6HN7ojjXf1Fpw20/C7+fxGefuQTbGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5rIUOPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5rIUOPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF141F00893;
	Thu, 11 Jun 2026 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183438;
	bh=uaTEN3kB2HJxSJttfepCdxyM5XDlYFdzNbqYENiI2Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5rIUOPk677MkmyKxmxmKvzoLmsfo8POCFrR0gNneCsfzxkcu4pZCUua/OS/YgKsV
	 DjSSKRdog6NVCkUfcCC/RgG1wnJaYDnuAplD/ReCqtnHT9yuhrVD92xWoB8D82RVkl
	 t3gWyhXUFy87JOx4AhgCLmJG2JJvlK/wiWrOpvx11zatd2jDchfQbMcUztiW5HPf4F
	 3CL9fmaJ9AOJkGdXferGnDYNpNUdUv3qWBCTKsFa019FWOVa/FAlYLOKloXdceWmN8
	 CcGV/JMpidbWzyXvOv+fZlWM5ItQ5FgwXCYBdJbNGZdx4GLkG7EAZ6uLiQaS6gSyFW
	 E+YXrHvPLxEiA==
From: Simon Horman <horms@kernel.org>
To: daniel@makrotopia.org
Cc: Simon Horman <horms@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
Date: Thu, 11 Jun 2026 14:07:51 +0100
Message-ID: <20260611130750.575946-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
References: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c

Move the phylink MAC operations and get_caps callback from mxl862xx.c
into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
PCS implementation which adds substantial phylink/PCS code.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 2f22adedfbf67..a193f3c07d359 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but the crc_err_work can execute after
dsa_unregister_switch(), leading to a use-after-free of ds->dst and
dsa_port structures.

In mxl862xx_remove(), dsa_unregister_switch() is called before the
asynchronous crc_err_work is cancelled via mxl862xx_host_shutdown():

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_remove() {
	...
	dsa_unregister_switch(ds);

	mxl862xx_host_shutdown(priv);
	...
}

dsa_unregister_switch() tears down the DSA tree, frees all dsa_port
objects, and drops the reference to ds->dst.

If mxl862xx_crc_err_work_fn executes concurrently or after
dsa_unregister_switch() has returned, it traverses already freed
dsa_port entries:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_crc_err_work_fn() {
	...
	dsa_switch_for_each_cpu_port(dp, priv->ds)
		dev_close(dp->conduit);
	...
}

Could this order in mxl862xx_remove() result in a use-after-free, and
should mxl862xx_host_shutdown() be called before dsa_unregister_switch()?
