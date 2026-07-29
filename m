Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B431F9B4;
	Wed, 29 Jul 2026 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290919; cv=none; b=Je3Qb63/VhDdm9D5lqAmcU9JU4tBpjkni7XTHt0FOY4Y/0c5N7JqTLu8BhU2kWY36IcWuWzaeOHrALMgKlR/ORCIsIBs/Ydns/BBYaDQuZhS4k1hTEWn3oy63qd/cfJ5FB6mIYGSVUU0lme7w5GnUSgDjUkyG+BsNUIzBHvkqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290919; c=relaxed/simple;
	bh=dmFAwHNDbuTtNzgQiK+co+6Dg8QsK3Gn18ASXDRVOG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSN1phFkMcbKDjJNmfd8PyejxpjMDC5EfFaDcmpeITd5jS7Jn0K7e17pYU7paPCo7rggUKGi9IljWZSJP8PcZJca7Vrq8BSCH5rjTSJyDw1QhX0AF12GQV8eDB+s9nE3v8XCvezjU4FtUgCm6m5GVszZCMUA1vFG0GO9RwCE1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjkAFax3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjkAFax3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FEB1F00A3A;
	Wed, 29 Jul 2026 02:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290917;
	bh=WsPE83tmT4fxK1BmxFBghnoXCTBkFHfLqN11t3edEy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjkAFax37v4PE0gvbRGfm8KAABk7kITFCs3IYFC8Q5qtL4Obqb/JXnwnzJ5IW51ig
	 Pdamv4nCfujyXXSkPZysadtOc12eW83HciQOVYaKcyz8vRmJErDXCRmBQOwRioWxfr
	 y0pNshRazhojXXQBtZKSO/Z9oAO4hbXT377y55gsURVPSUt9LDNBP6LE9/8Ue6Bewx
	 P9RSooDLYfCYDE8Mzj6jQELN+l3FZl3ur7FpIl5H7+GAKR7KIGKaZ1kj6cKDdvJslp
	 i0QvvpW6tv87BxHbIH1sGcN4b1HlwKbIERhsJ0Flxt95Z9WL0Vw9sea9SKVGGv+D1A
	 VdZdUhRQDbLkA==
From: Jakub Kicinski <kuba@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 4/4] bnge: send hwrm for interface down/up transitions
Date: Tue, 28 Jul 2026 19:08:36 -0700
Message-ID: <20260729020836.3656598-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724142954.3101980-5-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-5-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnge: send hwrm for interface down/up transitions

This commit adds bnge_hwrm_if_change() and calls it on the open and close
paths so firmware is notified of interface up/down transitions via
HWRM_FUNC_DRV_IF_CHANGE.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index e67536a8c430..220bdcced0db 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2861,6 +2862,24 @@ static void bnge_tx_enable(struct bnge_net *bn)
>  		netif_carrier_on(bn->netdev);
>  }
>
> +static int bnge_hwrm_if_change(struct bnge_dev *bd, bool up)
> +{
> +	struct hwrm_func_drv_if_change_input *req;
> +	int rc;
> +
> +	if (!(bd->fw_cap & BNGE_FW_CAP_IF_CHANGE))
> +		return 0;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_IF_CHANGE);
> +	if (rc)
> +		return rc;
> +
> +	if (up)
> +		req->flags = cpu_to_le32(FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP);
> +
> +	return bnge_hwrm_req_send(bd, req);
> +}

[Medium]
The commit message says this HWRM is added "to coordinate resource
management", but the response from firmware is never inspected here.

There is no bnge_hwrm_req_hold() around the send, so resp->flags is
discarded. On the up-path, firmware can set three bits in that response
(see include/linux/bnxt/hsi.h):

    FUNC_DRV_IF_CHANGE_RESP_FLAGS_RESC_CHANGE
    FUNC_DRV_IF_CHANGE_RESP_FLAGS_HOT_FW_RESET_DONE
    FUNC_DRV_IF_CHANGE_RESP_FLAGS_CAPS_CHANGE

For comparison, bnxt_hwrm_if_change() in
drivers/net/ethernet/broadcom/bnxt/bnxt.c reads the response and, on
RESC_CHANGE, calls bnxt_cancel_reservations() so that the following ring
reservation actually re-requests resources from firmware.

In bnge, bnge_need_reserve_rings() compares the driver's requested ring
counts against bd->hw_resc.resv_*. If firmware has re-partitioned the
function's resources but the driver still holds the old resv_* values,
that check returns false and bnge_reserve_rings() short-circuits without
talking to firmware, and bnge_open_core() proceeds through
bnge_alloc_core() with stale ring counts.

HOT_FW_RESET_DONE and CAPS_CHANGE similarly imply that firmware
capability caches and health registers need to be re-initialised, and
none of that handling appears to be added here.

Should the response flags be consumed here to actually coordinate with
firmware as the commit message describes?

[Low]
Also, bnxt_hwrm_if_change() retries the request in a loop while firmware
returns -EAGAIN (with a short sleep between attempts, bounded by a retry
count). Here the send is issued once, so a transient -EAGAIN from
firmware during a reset transition would cause bnge_open_core() to fail
immediately. Is that intentional?

>  static int bnge_open_core(struct bnge_net *bn)
>  {
>  	struct bnge_dev *bd = bn->bd;

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> index d177919c2e11..a1a939496ebd 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> @@ -275,6 +275,8 @@ enum bnge_net_flag {
>  	BNGE_FLAG_PORT_STATS_EXT	= BIT(1),
>  };
>
> +#define BNGE_FW_IF_RETRY	10
> +

[Low]
BNGE_FW_IF_RETRY does not appear to be referenced anywhere in the tree.
Given that the sibling bnxt driver uses an identically-named constant to
bound its -EAGAIN retry loop around HWRM_FUNC_DRV_IF_CHANGE, was a retry
loop intended to be added here as well?

>  enum bnge_sp_event {
>  	BNGE_LINK_CHNG_SP_EVENT,
>  	BNGE_LINK_SPEED_CHNG_SP_EVENT,
