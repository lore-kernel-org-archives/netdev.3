Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4C41E6C9;
	Mon, 17 Aug 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971466; cv=none; b=Y5DF5R+qcuq9UB7H9Etxp/5a44fzOLa1h04GiNNNwjDrZsptMQTXDOiNhGaERKnAWEItopKW5YM57r7rVO4DvQzTVMfH17q6/T0Gvh9vCYhQ9Eh+cJ+atcQS9kvrkoxVZedp/RQEia4j66/as+/56jEiNx3IU5YNQWjBWS9RIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971466; c=relaxed/simple;
	bh=Kr9+NqGxX/7rkik+zJxbR9+9TRciLZ/LeTYyjUnXEwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAcuf+zuRTKIgi8sLI9u5ADiPd8pD5/mcDNqR/OS8I+spEYb2Z3aCI/ABxvuWbh7SyzWLini47qLp2AAGyItMhFppJa3Nu0bAjln0rd0yMEz+qk2OdRyT4UOeM6iTMj/1XXmrtFYjR2EUY+MwKHqubqCCNYDvB7SYNa6CmN1kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=atQOa8X1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="atQOa8X1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jR90udMQKB9MCmNtBGkfjHvnHloBFfFG2p/ago2rX5s=; b=at
	QOa8X1Fg0lnuHMMSjgf1NtGqolQDq0h88h9sg+tnzks0GII1/jLWN4kCgkLjDXs0xtqM7C5G4BbYi
	kxFJSB0FEa5GYzji8bgDNQWe3hksgJh6IdeO2/Bdui5nAZlwwn5Qy5dCJ2nDcB+sg+dxSZL/h+Aqs
	3SaLauGFXbXcBuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wvwu1-000JXJ-Bl; Mon, 17 Aug 2026 14:57:21 +0200
Date: Mon, 17 Aug 2026 14:57:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Saravana Kannan <saravanak@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] of: property: skip links without a
 consumer node
Message-ID: <e8ca3655-5d79-4705-86dd-172465c255e2@lunn.ch>
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
 <20260816-submit-phy-package-fwdevlink-v1-v2-1-23e55dd59fad@gmail.com>
 <CACRMN=eU_C=sSXxoR_WY-LMPwD6H-bi366TXsbbDt0tPBmPA=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRMN=eU_C=sSXxoR_WY-LMPwD6H-bi366TXsbbDt0tPBmPA=A@mail.gmail.com>

On Sun, Aug 16, 2026 at 10:07:19PM -0700, Saravana Kannan wrote:
> On Sun, Aug 16, 2026 at 5:00 PM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > Supplier bindings can map a property node to the device node which
> > consumes the referenced resource. The remote-endpoint binding uses
> > of_graph_get_port_parent(), which can return NULL for a malformed graph
> > node without its expected parents.

If it is malformed, do we care? An Opps is a good way to indicate
there is something wrong, and it contains more information than a
-EINVAL.

> > Only create the link when the binding resolved a consumer node. A
> > malformed graph property then creates no dependency instead of crashing
> > while fw_devlink parses the tree.
> 
> Is this a real issue? If it's upstream, should  we fix the DT? If it's
> off-tree/down stream, should we care?

Good questions.

	Andrew
