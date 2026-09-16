Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40813349CD2;
	Wed, 16 Sep 2026 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538079; cv=pass; b=QURu86YAYrvyBmfc0bKUOi8UV09oiZVi7fgeiEzQonpHkI3QpZzWRMJLHSbmWu3b0ecIKl9AMY+U55IoEby3MLW6iQRrn3V0AU9r7JuohgOtXsxZ19NLAo5kOVoAtbBYcfY5viVNOIWhdGJFsmOqPyExle3fgRd29fVHh07WP84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538079; c=relaxed/simple;
	bh=7VPxp3B1Gl7oiT9mE1PYkfCbPRVbxVtu5CKXvqFiiEg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GkLXsli+ZUkjXbw9O7VS3sjJugKLdn/FuKfDsXWIWLwoJPYcoiw+qAOzxLAT5AmczN6hAH575ycT89DuxON6cLxhVsD3p6v8xtDJ0GpqtstUPypCJ4QkNq9SZlMq722i3TRbqyFtACXqH8JL8sj3hfin5j+HPJGWpD5fyhTZR8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HCAAZXI/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HCAAZXI/"
Received: from fauth-c1-smtp.messagingengine.com (fauth-c1-smtp.messagingengine.com [204.75.18.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hl7PW59MvzySb;
	Wed, 16 Sep 2026 08:54:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789538064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDqC/HPIfNfvuSsx83zdPTK1F3wWfSW0i1ycVhcmCBM=;
	b=HCAAZXI/Wpif8qdTPcazQMbYWKUAl5VI2+yYU+JQNH4oNi5B8MZj6gOVN7wwgHyftTUdh7
	gCkys/esi6FEwiBujajjzEy+EQm0Bsj+t2YoJBjscTl0DyMypEsfKVi34qfPvaCD3igsPE
	1kNKok/SMZfWxrVjisF0hfUtUsShptE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789538064;
	b=hKAl6R1RE1iXdFlgUsVWvEObXGGuZfu60UMna/ZHkX/YEVMKYt/AMrjeo08F6QS27yAz4P
	z4ei9pcHVJe/UUGrM+jqEP6+El9wa6TxvhjoWmda7wPP9Ezi49N6OBCEsAkp4xoZZuQd9u
	B+jlLjGypqt3uqAUrDwa6w0AIR6ZO+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789538064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDqC/HPIfNfvuSsx83zdPTK1F3wWfSW0i1ycVhcmCBM=;
	b=FlBRQ0zaq3tb0dpIKK/4nT0ORKOObw+xrmc9GLb3rr8h3wrcwMXEJeMW61SFWZebrsSnLO
	b/K5mhksGcz/STICoRfWzfhS2JeVvxRJosVN0VmG6uEZryo7A5Nb88sVcD8hgl+4d2B5Gw
	YAb28scRPtbyNmPabJqrNKLmqRNGips=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id AFA631980052;
	Wed, 16 Sep 2026 01:54:22 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Wed, 16 Sep 2026 01:54:22 -0400
X-ME-Sender: <xms:Ci-qaiVMZFrwdhS6C9HxvFDOVM1z7iEPVeRkndxuakxpeiJivwQj1w>
    <xme:Ci-qapZ9yLxHQ17k9xfIEjOdRk2zoiWaI8XbFeuvGxn-cbBVeTpn4vCMBqUji-znW
    CGYEhlYZEPz9L65fL_Tk6fEwJf4d6a5PfEfxn-SmuPClQOLCOUR3tM>
X-ME-Proxy-Cause: dmFkZTFURl2j0nXvDHDFYLB7Kc+qfRb/Fq1qdvpzuJNk/3e2E1JHui3UrZE2VVvNddZf0L
    AV+TGoBl78YpaIVHnJMdDQ8JVuQRdwMk0ewqpfwEVJpON9+YKqDH46FGTGp61wWV9FUYo2
    tq0G1TVu87vq6gu7WcV8CB4hgF664wxci3tFrqEpBBUMG5WXorW2TBjPn7BbZdxr5xUG7C
    VGJpJKBuATFkQ8KsQSW66ZneIGPc/PPlCM2g0XToXhlSEKvDrRVQwodzgxylrwEY/y6igV
    wbxdvsH7P2/gjvN+sa4VkEKZDNsdDMBhkXnq753Mw4f5Rc6MJgLMLRy2Q4G6r6pHj1rYgr
    eE9tSoRaQUX4PdPnsQfVu2TZWA6r8y5LQNgn7lo/oYeoyrYYDjeovh1ZwXulgY2sEQ9iR9
    2CBFaoEUlG0IsaOZ3POI6GNbqFs60exacJTRvCu/Of1zSQ27QEZ5xREUGufsA5j1RTslOG
    jtSCiNQszBaNYBL+qTI8/H+mRwmnnS5hGUoucWdw5iMfBBB4FuMuE1W2SV4sN6uT8B/Vv3
    kBWFvsNBo9ghedWk4NVGo8cysHntLdXoKXDMjZlRm9+OVPVHu3E969U0QHq5idi1R3KVkQ
    9bu4yut1tEIRC+LNrpKcNznJPjANnuAJffWPPk2l267rGz7fr/TMOzTt/npw
X-ME-Proxy: <xmx:Di-qaqeYe2x73OWTcAcE491AYG93_x69Z7OpMpdf-ocooh8qhKHosA>
    <xmx:Di-qavoaA8fBPZN0i8hK9fCidfw_4DX4GKTupUahuJNF1-4xrxWs5Q>
    <xmx:Di-qaqM--IBv2Nx_o4CEo_nVHw6-hmJ2Pu6QKGCbivBSEgU7Y1vpvQ>
    <xmx:Di-qalFM32JGM2h9BDCVcFQWRXgl7eD23GD8pUW8fMzuS8S8i20dMQ>
    <xmx:Di-qatGQmngdPE7_ClIkJL7y96JNuN8MQuDKDH2EZ96u8SXRu4gedR_O>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CA2CFF80089; Wed, 16 Sep 2026 01:54:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0bevnK5BUW7
Date: Wed, 16 Sep 2026 08:53:26 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>,
 "Jeff Johnson" <jjohnson@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>,
 "Mihai Moldovan" <ionic@ionic.de>, "Denis Kenzior" <denkenz@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Andy Gross" <agross@kernel.org>,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org
Message-Id: <da6003cf-515b-4d97-8059-3f4553d0251d@app.fastmail.com>
In-Reply-To: <20260915154705.67cfb94f@kernel.org>
References: <20260915054207.2513877-1-juha-matti.tilli@iki.fi>
 <20260915154705.67cfb94f@kernel.org>
Subject: Re: [PATCH v7 00/15] QRTR Multi-endpoint support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2026, at 01:47, Jakub Kicinski wrote:
> On Tue, 15 Sep 2026 08:41:52 +0300 Juha-Matti Tilli wrote:
> > Subject: [PATCH v7 00/15] QRTR Multi-endpoint support
> 
> qrtr usually goes via core networking tree.
> Please make sure you base your patches on net-next/main

https://github.com/jmtilli/linux/tree/netnextmain_multi_qrtr_v8_multi_ath11k_ath12k_v5

That will be the next version. I'll wait for a while to see if other
review comments pop up for v7, then I'll post v8. At least the
current v8+v5 QRTR works just fine on my multi-card setup.

BR, Juha-Matti
