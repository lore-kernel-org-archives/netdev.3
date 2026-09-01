Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB247CC75;
	Tue,  1 Sep 2026 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265235; cv=none; b=otc9MLVv7Onba48/AHKcQTCbHHeAqnZ6nsCXewGtqm2BnUXbMN3476+QDhffNpQqO+CKnIeWT8LGQ0ikdqiSgoWN235/wij6SCC2/kNcIqDEXF1gf8z4naFA0ZkirVfdoWUnKScnj5dqJeu7+ZrhUC0NPskndoL+4JOcjBw1Ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265235; c=relaxed/simple;
	bh=Ms5yUYYVIUCMr7+Dx214kheiE7jKpBdWV1rFqMcG+C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB78j5yoe0zeIy8lEXyA3SXddm03SINcKNt7hOqwkpkPHAOc8Ms68jUL476Ur6L5nbE3t+egElockKeak40cg1tEB00WXlSVBCOOEJJdyKkO1+mMUU8X+rAg30c/Mp0dO3SxYM+nvyrJ6v2KRuTRuWudXVlBvrnWKvlpyy/3EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVCDtES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVCDtES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52B1F000E9;
	Tue,  1 Sep 2026 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788265234;
	bh=knqgEaQ3Nt/j1kgI3GiULCfkTBJyPDx6YekcweuXbC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XzVCDtES9FvYRwTEGc9GrdSsXkl6cVu5UXSDTum7lXO3LWqCLtN+EXaqrgdN6hcuP
	 3OrxkBXK3RjdrJeeLI/0bMQBaJ+ENpefSMLaVjuocWSFwmZ6GMfxx7oDYWyv8N0zBE
	 G45G+qxb1zudvuGlCeaVk39PiCS9L2W1Wcgfl5qkR8CtuoJXn906kmVLfHXv1XLXyq
	 tCGGUrHonlTdH81NrBePv0pYG0mZO3XmPN42ul1VU0dzC8Y8ut+6TaO4jfz0wI1G9a
	 1Hm3Q4YEeZnZ0BA7vHLJ6seqCgz4sMz34z4XDxfvDIEy5PrHcznAPOfFcyS+RhwLuR
	 8Lmr/WfajOQFw==
Date: Tue, 1 Sep 2026 14:20:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Peter Hunt <peter.hunt@opengear.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, netdev@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/3] net: wwan: support DTR/RTS on AT ports
 via MHI IP_CTRL
Message-ID: <zjafvc6ndpkmavogxwmqj5gpefpj4ymefn5obed6cvjot7wnwa@pmrfl5tixa72>
References: <20260819224927.2274790-1-peter.hunt@opengear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819224927.2274790-1-peter.hunt@opengear.com>

On Thu, Aug 20, 2026 at 08:49:24AM +1000, Peter Hunt wrote:
> Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
> result codes until the host asserts DTR.  The in-tree mhi_wwan_ctrl driver
> exposed AT ports but never signalled DTR, so URCs never reached userspace.
> 
> Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits) port
> op.  The TIOCM bitmask state is tracked entirely in the wwan core; drivers
> receive the full bitmask so they can drive DTR and RTS independently.  The
> core raises DTR/RTS on first open of any AT port whose driver implements
> ->dtr_rts and drops them on last close, mirroring TTY semantics.  In the
> ioctl path mdmbits is re-read under data_lock inside ops_lock so the value
> passed always reflects the committed state and concurrent ioctls are
> correctly ordered.  wwan_remove_port() also de-asserts on hot-unplug.
> 
> Patch 2 enables the IP_CTRL MHI channel in the Sierra PCI table so that
> the IP_CTRL driver (patch 3) is actually bound on those controllers.
> 
> Patch 3 adds a second mhi_driver that binds the IP_CTRL channel and
> registers a ->dtr_rts op so that the wwan core's open/close DTR raise/drop
> and userspace TIOCMSET calls both reach the modem.  A single recycled sink
> buffer keeps the IP_CTRL DL ring live so the modem's transmit path does not
> stall.  The existing AT/QMI/MBIM data path is untouched.
> 
> v4: https://lore.kernel.org/netdev/20260816121705.858013-1-peter.hunt@opengear.com/
> 
> v5:
> - Change ->dtr_rts from bool to unsigned int mdmbits (patch 1 + 3): DTR and
>   RTS are now driven independently; fixes RTS inversion when TIOCMBIS/BIC
>   changed RTS with DTR in the opposite state
> - Re-read mdmbits inside ops_lock in the ioctl path (patch 1): closes a
>   concurrent-ioctl ordering race where two racing TIOCM ioctls could leave
>   the modem line state inconsistent with TIOCMGET
> - Add ->dtr_rts(port, 0) call in wwan_remove_port() (patch 1): ensures
>   DTR/RTS are de-asserted when a port is removed while an fd is still open
> - Update kernel-doc to note ->dtr_rts is AT-only and describe mdmbits (patch 1)
> - Pre-queue RX sink buffer in mhi_wwan_dtr_probe(), requeue in dl_xfer_cb
>   (patch 3): prevents IP_CTRL DL ring from running empty and stalling the
>   modem MHI transmit path
> 
> Peter Hunt (3):
>   net: wwan: core: propagate modem control signals to port drivers
>   bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
>     EM919x/EM929x

FYI, this patch got applied to MHI tree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
