Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AF2931C1;
	Thu, 10 Sep 2026 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006345; cv=none; b=ubHqE/c81WNeWVR/bN7h8l2HgbJHy7jId+RLUJNAvMb617JXtg2ARSCYKV32LXcLA11dFiMDRE51ZHuDR5wduC1jHRiEjlwHeIvNrqlXW4uuUXiVMVTfM3t95dMP580vIzZJmjjkaaziQn8Vd0kD0Srx8d0v26SpD71cKKAWUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006345; c=relaxed/simple;
	bh=BWzCCdEf/sZzKu6OvipNlaHbzyMiK+WzqEnl/OfaOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elRrdEuMvjnKZ91BQFaNesJ0Y2V1vDtWLdT4UOimJhvzhnzw3MelAdQhFjwHGJ0PK2XhXMTe/nrSLF4AJpo3pxiVZq88tynuwotlh+UT132vS69HH9hjRY3sdYgtR6ut6en6s4Zj8sPsMPAjPC3apksq51l7LPl/zpY0FN1LRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KscgrVCZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KscgrVCZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jGsz/AIlg5zkRhqib8+rxPKlP5FHVXhKZMGyojJ8N8M=; b=KscgrVCZFZYlw91Zfay36req7N
	H+xB8J5nRlxqnmO4DJyEFdZk7QSJlpNFWMTLkzfQskL/eaUn53hrCUrEd1l/PLzmmytAPjQ2g/ZZE
	ljxyu8D0D96bMzqDP6vHjAbBbQ/75IJQ1Xf5uCjVHBlwmuAhBfXF5MwP3LxLcibuME24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4UGP-004Pzi-CH; Thu, 10 Sep 2026 04:11:45 +0200
Date: Thu, 10 Sep 2026 04:11:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, vadim.fedorenko@linux.dev,
	maxime.chevallier@bootlin.com, dong100@mucse.com,
	wangruikang@iscas.ac.cn, 25181214217@stu.xidian.edu.cn,
	hkallweit1@gmail.com, han.junyang@zte.com.cn,
	xuanzhuo@linux.alibaba.com, enelsonmoore@gmail.com,
	jes@trained-monkey.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: econet: add EN751221
 ethernet
Message-ID: <a9eac625-f0f3-47db-ac2c-26c7df66f52a@lunn.ch>
References: <20260909212146.3184077-1-cjd@cjdns.fr>
 <20260909212146.3184077-2-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909212146.3184077-2-cjd@cjdns.fr>

> +        gmac1: mac@1 {
> +          compatible = "econet,eth-mac";
> +          reg = <1>;
> +          status = "disabled";
> +          phy-mode = "rgmii-rxid";

That is a very unusual phy-mode. Is there a reason this is used in the
example?

	Andrew
