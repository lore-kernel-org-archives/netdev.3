Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431856;
	b=YPlh2LQbXprWhhv0nyIyOjNSuM2Jsvqn/LxroV8wwnu6JT/TIXr8utaNZyMxhLL5ewUt
	 lAQEtqtgHhHm1RIl0weWNpzfMJIznA11g90sRKHeL4u3GBfU0Y9LaQAEA287Pt6TIR2aR
	 jSFOWkROrIO1zPF9oogM196wMUo8k0jFc8D0A+Q4l0S3OHTYcxaCay/rKdj7jHs6I7yp2
	 W3rDlJ8dIxrLjtH8KNJ7YbkyKSr2Y1SsEhnbU4ZOn9SnhyS6nr1Pg9n2SObgBFpI0mKtX
	 JSwPG/RKEXj2Fs9MUUHZezwyyNBtFqluuecVbi3ljMyHeA2+gL5vOCq7EABs7HwA9Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RbLGwr5xM5Iu3cM4Nx0Zc0qbDlMYiMX8eqFa0Wsah9I=;
	b=d8GQsz8leNGxdepqULoYfjsqTaH/N1yggT8nXm2Q9qMDv3+Pv4Dsu0Wd8ipMFvU9phwn
	 Wdg8/4DzxPylTGgGRsRYRNsdEd03wFX6llXb3L8/f9tcAjJhE9SGM8oUaCmLC1wkjKHpW
	 Y8j3Ktp21jqNPs9LTBE7RP8jE1/mmA0JAMGqop8YbXPVCC1a7XALCgB4AINLfDGpHF6GT
	 kfoBssCgRNIVnttPFip2XWGE2H4YY36gZ+iRcIHWucAhoPde9WK6AdRFyMSMfHomVI+yM
	 38EcZ/zcy/po2UoC8LO1Rvlt0+/8fQdt7So5xZ8hsoXYiq34Pc+vPbLGttyhlORFuEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWYX+haR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DD606A330;
	Wed, 11 Nov 2026 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWYX+haR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857191F00A05;
	Wed, 11 Nov 2026 21:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431856;
	bh=RbLGwr5xM5Iu3cM4Nx0Zc0qbDlMYiMX8eqFa0Wsah9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HWYX+haREpS5zSKCy9SnLY//eVV2pSLn6+4VMoDg6QnC9Ohbi3J04qUeh4jmM3Bc4
	 2jS3aagPHOS0TkqQbMQKLUtgUzFYTFQ/PEvik0xkMmVi+uGG+bbFcBnOeID2l6Zezg
	 zScBceQowSpgpQdrhp33i9Y6mG4lR1DdZU4hwaYklQnCs+H+xnihvsjCYmICu4lW6J
	 FazqqBQF35dQrLBfHjC+FMAnBiEVJMOt+AeyAIW6vWurNvR6xQkmvCIrLAex9Ihzen
	 FqjyvzxeUkfcup8VgsDuzSxML/SV9tMmBpHI8oCtz3dwE0j34nj0tDTechm/fc9WQw
	 fDiMbbiAq+yTg==
Date: Wed, 11 Nov 2026 13:17:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>
Subject: Re: [PATCH net-next v02 0/5] net: hinic3: Bugfix for later
 patch-set.
Message-ID: <20261111131734.51512ade@kernel.org>
In-Reply-To: <179437094656.2168702.7238120951030130700@kernel.org>
References: <cover.1794371175.git.gongfan1@huawei.com>
	<179437094656.2168702.7238120951030130700@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 04:22:26 +0000 netdev-bot+sinfo@kernel.org wrote:
> If the series needs another revision for other reasons, please
> include the information in the commit messages then.

You're supposed to add the info to the cover letter when you post
new revision. Please read the responses in full :/
