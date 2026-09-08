Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819653447C;
	Tue,  8 Sep 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870521; cv=none; b=DdM9b6cq65cGNhvrxyOLYv2rkWAlXyiqQQgUjjkXv8T7ecgWEVosoEEo0qxjrFIa9TvIzsEDOvaLmLUKbg9ZojUOmesTzbmhSwGwKCsTlcq6yZ1OJ7iLWeyzILLlEaDhD8yZNh4w5WQVxrq6fGeDmYibc11cYpctOoNb+b99h94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870521; c=relaxed/simple;
	bh=s+Y2stGxRurK4pAcopFsEGKF4ANNUugOxT52sCLvlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvXOSiNi6Pa0YFbfBIKZRanwCoXj3EViafFdZ+San2q/cis4WGcapXcIqYNtti6bAYuqkWYLdsROG3GPY72+9CjSksVU3WvTTpr0/+BVhPDXBlzQmwfWmjZ0/I0CvAC0S7s08+AMLkwVFe6+OxloNzmjHHLmb9wg6Ilc4Yi1H4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PARWB6Uq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PARWB6Uq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=72D24EU3D896jK8KCZiPhgeRJp19b5trtsxelYw82pk=; b=PARWB6UqovKI1nx3IF5PREzsqV
	Qgyj8HJVqIRIlX8LgJLwVddYi2Oc1CWXoChEm6QOYLKk0D5oWpZ9XG3FF6svqTKA9LgYLPIJyQXqT
	3np6xjnWGHXJBjwb1MvBGcTLHXTWElz/75XpuI5OD53WREvyhPj3Kge8m72uZIVd5vZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3uvz-003t72-NG; Tue, 08 Sep 2026 14:28:19 +0200
Date: Tue, 8 Sep 2026 14:28:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	John Crispin <john@phrozen.org>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v13 1/6] net: dsa: add devlink flash_update
 callback to dsa_switch_ops
Message-ID: <39ce1c25-55d8-4bd0-80a7-72ac881161ad@lunn.ch>
References: <cover.1788783126.git.daniel@makrotopia.org>
 <ca7ce5efa19afc93bede2b5bf6841b0b47eba4ba.1788783126.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7ce5efa19afc93bede2b5bf6841b0b47eba4ba.1788783126.git.daniel@makrotopia.org>

On Mon, Sep 07, 2026 at 07:37:37PM +0100, Daniel Golle wrote:
> Add a devlink_flash_update callback to dsa_switch_ops so that DSA
> drivers can support devlink dev flash without open-coding the devlink
> plumbing. Like the other trampolines in net/dsa/devlink.c, the op
> returns -EOPNOTSUPP when the driver does not implement the callback;
> the devlink core will then have fetched the firmware file from
> userspace before the request fails, which is acceptable for an
> operation as infrequent as a firmware update.
> 
> The devlink core calls the op with the devlink instance lock held and
> without rtnl_lock, whereas DSA serialises its switch and port ops
> under rtnl_lock, so a driver has to serialise a flash against its own
> ops itself.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
