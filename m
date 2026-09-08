Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88353CA9F;
	Tue,  8 Sep 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871004; cv=none; b=iPYzS0UG85OypMQmwF+zaAIwYwHkhGP3UajwcTkkWfw6UDiN7zUnIaC/ZvmTJuny7SyPrxdZAaShxUzX+rT6MqkauMhKMrlzl5Vj3Noo0c5n9CnF7hb8sYH+fkxhzphWfQSghliulUdp+lY/3heTRyryi4YuoJQ2HQUwOjDeX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871004; c=relaxed/simple;
	bh=957+TI9GavEt5/GySl50hjQxz4amoM7kCQBIQAED39k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxUkEYEf3WbJ/M8Xembf5CBk4qpwCFkM31Nq4Ibl++Hzi/oB7ZwWJiISszmo73qgSwxvDdcuoMMd7hgD+BTzQbDwMbA82/5DNL8pYbBoqBwaeYfQdrZBfdBs9SGETjC1jgkry6xcvZ008F1rCnNSO8WLD/oinyUi3h1BVvnCMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dJw5CfY3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dJw5CfY3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gAcjPZRECkGWrXrhyA/cJSqSwDpJVsSMrR6tugnf2sQ=; b=dJw5CfY3qibsIkEZMR+XvHFz3M
	HWmXgMtyQd5LFyE/3B8qkb00e7MMoBbd2Kkllt2vCwqHziKngtLZSbXzZRZOQwqxgYKsYl2f0Cx7H
	JvB/GKuG2OILnmePyymzYYM/ieFdqfFeHDoR8QzXcSjoRv6fO/GcjwcpoYAnqyXgiX40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3v3p-003tC3-1x; Tue, 08 Sep 2026 14:36:25 +0200
Date: Tue, 8 Sep 2026 14:36:25 +0200
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
Subject: Re: [PATCH net-next v13 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <c825c54d-a5f7-4ef7-a19a-bc0a78da0225@lunn.ch>
References: <cover.1788783126.git.daniel@makrotopia.org>
 <0f075bdb2c3740d502ab1211f2d20e44ea055c75.1788783126.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f075bdb2c3740d502ab1211f2d20e44ea055c75.1788783126.git.daniel@makrotopia.org>

On Mon, Sep 07, 2026 at 07:38:28PM +0100, Daniel Golle wrote:
> Implement runtime firmware upgrade via "devlink dev flash" and version
> reporting via "devlink dev info":
> 
>   $ devlink dev info mdio_bus/mdio-bus:10
>   mdio_bus/mdio-bus:10:
>     driver mxl862xx
>     versions:
>         fixed:
>           asic.id 8628
>           asic.rev 0
>         running:
>           fw 1.0.70
>         stored:
>           fw 1.0.70
> 
> The "asic.id" and "asic.rev" fixed versions carry the numeric chip part
> number and revision from the static CHIP ID registers (SYS_MISC_REG_RD),
> which userspace such as fwupd matches firmware against; they are omitted
> if the read fails or the part is unfused, so no bogus "0000" is
> published. The switch boots its firmware from its own flash, so "fw" is
> reported as both the running and the stored version; a flashless part
> would omit "stored", distinguishing the two without an API change.
> 
>   $ devlink dev flash mdio_bus/mdio-bus:10 file mxl862xx-fw.bin
> 
> The image, including both payload CRCs, is validated first, so a
> malformed file is rejected without disturbing the running switch. The
> driver then sends SYS_MISC_FW_UPDATE, which reboots the switch into its
> MCUboot bootloader, and transfers the signed image over the SB PDI
> protocol (clause-22 SMDIO), checking every write: a failed address write
> at the half-bank boundary would otherwise misplace half the payload
> unnoticed. A successful transfer reboots the switch into the new
> firmware. The loader verifies the image once the last slice has been
> programmed and publishes the verdict, so a rejected image is reported as
> such rather than as a transfer timeout. The whole cycle takes just under
> a minute.
> 
> For its duration the driver closes all user and conduit interfaces and
> marks the user ports not-present with netif_device_detach() so userspace
> cannot reopen them; the conduit belongs to the MAC driver and is only
> closed. This also stops phylib polling the switch-internal PHYs,
> unreachable in MCUboot. The bridge's deferred STP DISABLED transitions
> are flushed under rtnl so they reach the firmware while it still runs;
> the stats poll and CRC error handler are stopped; and firmware API
> commands from other paths are blocked under the MDIO bus lock so none
> reaches the bus once the switch has rebooted. Progress is reported
> through devlink status notifications.
> 
> The switch leaves MCUboot on its own by booting the new image, but the
> driver has no in-place path back, so it reinitialises with a deferred
> re-probe scheduled regardless of the transfer outcome, using
> device_schedule_reprobe() from the previous patch. The helper's work
> runs in the driver core, off the devlink caller's locking and signal
> context, without this driver holding module or device references, and
> it skips the re-probe if the device is unbound or shut down before it
> fires, so a stale re-probe can neither undo an administrative unbind
> nor detach a device whose ->shutdown() has already run. During the
> teardown the driver's API reads return -ENODEV and writes fake success,
> so it neither stalls on the absent firmware nor consumes buffers it
> never filled; port_mdb_del() takes that -ENODEV for a MAC table that is
> gone and reports success, since there is nothing left to delete. A
> failed re-probe leaves the device unbound, exactly as a failed initial
> probe would, and a further flash is refused until it has run. An
> aborted transfer leaves the switch in MCUboot, where nothing here can
> reach it; the next patch adds the detection that makes such a switch
> flashable again.
> 
> Scheduling the re-probe can only fail on memory allocation, and only
> after the switch has already been flashed. -ENOMEM there is a
> system-wide condition that no driver-level message or recovery attempt
> improves, so it is returned as-is with no further action: the driver
> stays bound with its firmware API short-circuited, and unbinding and
> rebinding it runs the same teardown and fresh probe the re-probe would
> have.
> 
> The closed user ports and conduit are not returned to their pre-flash
> administrative state across the reprobe; userspace brings them back up,
> and restoring it in-driver would need DSA-core support that does not
> yet exist.
> 
> Assisted-by: LLM
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
