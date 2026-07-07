Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFC2E764D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418477; cv=none; b=cZ0HWKH+mH+lGbALpp6ZCyXyx14btLitK7i0G6QgO6v+0erSxV+UN4XP++Il/OctQkhQYexSicicnHdVIS5aCOSZj9kKzmAT1A2S8PVlJDxHvdiVFS0RZ3vgtkohLF7+yTlnqOOuJxOF655XfDUTiHtRMM7fuFp9VJWNIpbjlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418477; c=relaxed/simple;
	bh=vXskx8sM2yRTZ9zWg7B80bBzs5Zdx1sEmmoJCthXhm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4DOf6d5UzjFs757ePcmxAVuvs4hVaZkPJm4xba2zBYwPCh8GdgEvvHDwLByrYLFjcSZoiFCnF9sB7ywRqRJj+kA6sGaZNETYCpsXrP+IbHXwRG/xjLgGagufuTcNwwF5YqFXL6meK5//yGwV0/zin7+qoNZLw4JfJJOnuULwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5RZKxHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5RZKxHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72251F000E9;
	Tue,  7 Jul 2026 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418475;
	bh=xPQ4gR/CN+dsW5qciUqH5gfy4g/srZkvzGZXLhHrpgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5RZKxHpJANpzEmY/Iy/y0RkmifUbaiZL+1Aa9yXMBMr1yV/hi+BV5pvtiSUm9ZOw
	 CVXhJ1WFLopXiqFkrWzXPnl9EwXcIfRYx7j5cPPCetuQ+76uEd/Uy97aBwrh+KSzn7
	 Eh78Q50nsKhscTG8qLaELKuS3hWXu2axRF77ewtBGRRO1d3q9LNyWXX2oWBPsQcDOC
	 dh5r2SQue4mFMgTIdVwkr7rWbatzwzx/MSqNm9cQGWwdRzlhDHwAPUhg/6dQoTPhAx
	 0qhFtN7kPxOHEVGJIaFuSThdQIYfE3UxlFf6qNsAZoAC+ABJuBnCrhOPNiC3prx8CM
	 yXHfVPcwCRUsA==
From: Simon Horman <horms@kernel.org>
To: dddddd@hust.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: clear active_target when the target list is replaced
Date: Tue,  7 Jul 2026 11:01:05 +0100
Message-ID: <20260707100105.1380119-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625111835.2411251-1-dddddd@hust.edu.cn>
References: <20260625111835.2411251-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
nfc: clear active_target when the target list is replaced

This patch updates nfc_targets_found() so that when the active target
points into the dev->targets array about to be freed, the cached pointer
is cleared and a partial teardown (presence-check timer stop, dep_link_up
cleared, rf_mode reset) is performed before kfree(dev->targets).

> diff --git a/net/nfc/core.c b/net/nfc/core.c
> index a92a6566e6a0..950807906645 100644
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c
> @@ -786,6 +786,21 @@ int nfc_targets_found(struct nfc_dev *dev,
>  
>  	dev->targets_generation++;
>  
> +	if (dev->active_target && dev->targets) {
> +		for (i = 0; i < dev->n_targets; i++) {
> +			if (dev->active_target != &dev->targets[i])
> +				continue;
> +
> +			if (dev->ops->check_presence)
> +				timer_delete_sync(&dev->check_pres_timer);
> +
> +			dev->active_target = NULL;
> +			dev->dep_link_up = false;
> +			dev->rf_mode = NFC_RF_NONE;
> +			break;
> +		}
> +	}
> +

[Medium]
The commit message says this teardown mirrors what nfc_deactivate_target()
does, but nfc_deactivate_target() does not touch dev->dep_link_up at all.
Forcing dep_link_up = false here when the active target was set up via
nfc_dep_link_up() introduces a state mutation that is not described in
the commit log.

Can this leave DEP/LLCP state only partially torn down?

Compared to nfc_dep_link_down(), this new branch skips:

	rc = dev->ops->dep_link_down(dev);
	...
	nfc_llcp_mac_is_down(dev);
	nfc_genl_dep_link_down_event(dev);

so the driver is never told to bring the DEP link down, LLCP sockets
bound to the local are not released via nfc_llcp_socket_release(), and
no NFC_EVENT_DEP_LINK_DOWN is sent to userspace.

A subsequent userspace nfc_dep_link_down() will then be rejected here:

net/nfc/core.c:nfc_dep_link_down() {
	...
	if (dev->dep_link_up == false) {
		rc = -EALREADY;
		goto error;
	}
	...
}

so the normal cleanup path that calls nfc_llcp_mac_is_down() is no
longer reachable from userspace until device unregister.

Does this risk leaking the LLCP sockets that were created while
dep_link_up was true?

If the goal is just to clear the dangling active_target pointer, would
it be enough to clear dev->active_target (and stop the presence-check
timer) without also forcing dep_link_up = false and rf_mode = NFC_RF_NONE?
Alternatively, if a full DEP teardown is intended, should this path call
dev->ops->dep_link_down(dev) and nfc_llcp_mac_is_down(dev) like
nfc_dep_link_down() does?
