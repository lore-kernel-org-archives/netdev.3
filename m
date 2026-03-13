Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4ECA4E;
	Fri, 13 Mar 2026 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773374574; cv=none; b=bUpWUwEBH4TzCQv4GBsnTkk2WD2wRQz/iN7O9+DhYAbJ4Lhx2CDVVfe6mcbhDr73HQDumV7DCs1jr8Xv9d9EjMO77is9E2eLVPc9cB6X+/jxU8OPtjGRaDtziTYowhWnuN51nxW24/RuOLgxq2Gt73i2ogCxGrLzWLDCwkiU06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773374574; c=relaxed/simple;
	bh=jVxQTuXNmbEmh/uDB3HXYo4fWHQYyC9hjvQqEMOpuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ8mHBCmvnnwPtA43XB8lgGiC/bWtRvtIggsKcE5AeDYqUszXqeTJroq5oouV1i0DPJItWyKFvcui5EnCxKZ2SPfBAlxGisARTK2wrRVNEiIoaQ48TCAZsEBMWld8IzqWxCEVUEg+DtJTT2LVhMlcrfsrFvXN/lEuz5kcR2AFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w0tjS-000000003Zy-1qz9;
	Fri, 13 Mar 2026 04:02:38 +0000
Date: Fri, 13 Mar 2026 04:02:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <abOMVcc93Ik_V5xy@makrotopia.org>
References: <cover.1773286076.git.daniel@makrotopia.org>
 <268f1d8016b15ee462da9a465ff269310e44aa2e.1773286076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268f1d8016b15ee462da9a465ff269310e44aa2e.1773286076.git.daniel@makrotopia.org>

On Thu, Mar 12, 2026 at 03:33:30AM +0000, Daniel Golle wrote:
> Add support for bridge offloading on the mxl862xx DSA driver.

> +static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_mdb *mdb,
> +				 struct dsa_db db)
> +{
> +	return mxl862xx_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
> +}
> +
> +static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_mdb *mdb,
> +				 struct dsa_db db)
> +{
> +	return mxl862xx_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
> +}

The .port_mdb_* functions were left-overs from my previous experiments
and should not have been part of the submitted series. I've noticed that
only now. Apart from that this patch is ready for review imho, so I won't
send any new version at this point until receiving more feedback.
