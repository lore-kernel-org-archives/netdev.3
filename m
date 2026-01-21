Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6924E4A1;
	Wed, 21 Jan 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000904; cv=none; b=saeCNllUydL5KyAAxeVdAyFCijHqiX+shN37/FaN9XOeb1vZv1z5NO7SrbMjk4Q2POmDG6Kovf9ADQ7T+hRCFmpu+7iAolixeBhOu3Vl8cvkv6MiZ6QTjNOl+KhVuD6IbFlkKKuk3pgZmq+sYglqGKAq4N3UbK5DAqGB2VBv8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000904; c=relaxed/simple;
	bh=NrXdFStxEa2mOJ95/o5EvA1LtOMRovnSBIfwW+kqwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCkJhN+fdeCMqw6g9zmApZyQgDm2lCJ+BNyU/zSwrmeyj06Sw6Lynic69pPpIpEBxWbY4oTSSSm1IdSBfweKEPkY/x9aT5rOxrit8GFoyKsyWYIbuUSlLhEHVQMTgND1Zj3nRr8szkoHbnvFZNvIwnDvZYCpGv9MgImtlIUF6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g4QLjE3L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g4QLjE3L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DjtY3Y+EVEI/+uy6UNTO/Ue3hBblWM6Fgy18ZlQf6Fc=; b=g4QLjE3LFY2vITAsFa3+w6Z7FN
	4WywkWxyuzChy2NhrO6DDYvKhcVfQPUVMOVRaqOy1MEEcFiI6caLcZB2jn6wWk6j1umb/iEKGY95a
	tZZhZGK/b6Wr0rFlHZ8N0PBeDBQ4h/PXVH4uy98J6TJucwZRl73J6q0svGBiRRLG1LmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viXwV-003ou5-QL; Wed, 21 Jan 2026 14:08:15 +0100
Date: Wed, 21 Jan 2026 14:08:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Message-ID: <388baa3c-c959-49f7-ac0b-99c2ea266690@lunn.ch>
References: <20260121130704.2236452-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121130704.2236452-1-weibu@redadmin.org>

On Wed, Jan 21, 2026 at 10:07:04PM +0900, Akiyoshi Kurita wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
