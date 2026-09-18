Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D83BFAEB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698632; cv=none; b=RZ4hlLd3ZSyGpr5BISQGqbeCEULWXX93Q8I8iCIo8je4fdo8qb03zxsMbEXzBNAs7DvRC5XaPLfL9MjLVCprYkjIZjWFL1LdiVykQbAZ/0b5sZvM9BVnUPLCHdBRcefbkXgUKgs1rbbH/V32ukuWYiywbBkfyx3bFfM7ZD9zAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698632; c=relaxed/simple;
	bh=yHUivfFU7qlUaZppomgzcNlfw0RapaHanUo/BAzXze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF9AGbufjkmCaebBDFucATQToOFbJnbWDBHU6wBK+WofgrxBdzBEynpvPTpgTPAJVVw5TcIPa8iZLY8FC9nk7WsIlURYNty5VfSDQZ7xsB5UVuJm1gm/gPUuErZYKomj78Z813Bp+qv0AaBmS+7W9KCoT8UaAfCfN+CXj5r3C8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GNybPAbc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GNybPAbc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u+WJMZPTdsBV3O8R/WKXRr4qtbJ4eOiMicexx5vtJKE=; b=GNybPAbcOE5C7MwaxEMafEr65K
	xsk3YSWRabA0LwsEisRdvPqsmQjzO+eTadgYhaYASguaHcAmnsoYbUMsawxE9NJkyRJikRKZZ+6s1
	74F5cCvxos5gCrAc8qD2VHZRjpXUZwhV25N9dLWpXornfx5eY00WkaVYhxum12Y01u0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7OMh-005msj-Vy; Fri, 18 Sep 2026 04:30:15 +0200
Date: Fri, 18 Sep 2026 04:30:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: Re: [PATCH net v3] tg3: use random MAC address when
 tg3_get_device_address fails
Message-ID: <0cb5dcee-4b94-4779-ae4d-ebaa429bd21a@lunn.ch>
References: <20260917223416.GA245819@visor>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917223416.GA245819@visor>

> +	if (err == -EPROBE_DEFER) {
> +		dev_err_probe(&pdev->dev, err, "ethernet address provider not ready\n");

Please go read the documentation for dev_err_probe()


    Andrew

---
pw-bot: cr
