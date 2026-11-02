Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623893;
	b=aSWt4ST3wnEDJseVyTiWUjh4VmzvmbakBySAUBZeyCqG92BN1XRmH2XzF5r6wX2+wUmu
	 S4lhjkwqwIgJGl+FYfnGK2l/IjKurFkqaATjEwPhG/doW0+VGJ15Aw7WOY+PAZ5q8Vbb+
	 arAnKLCzZ9YX/IpoyFkm0MW8A1v1y+tr6sO06Xq1U30jMVPnny7rOTMVMXTgaIK0WSrrS
	 cpu7Gba5k6e+BQFl2VCes7Bj1+kDoO2Wq9FKDjezO+8r+9JFtUIP+lnLPEXRFOybH2jJD
	 3iDkSHNVHBsR96HSjeBLiFpyBzTPNifaO3Yw/Ut8YZBZcrwt1iQJA93oLlh9dMZDTdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DZ2BPSbxMQYorksK3m6ueXVADbHpGJpfrkPqJkBaJv8=;
	b=b0uXhq/iTQInN7wknnblcnTzm9EKpQ6Nh0zVbLmI5RWgXeHsgJDO5FHS+q0APCLipsjl
	 hMdjlA80k0JSzpoIx7C2LiKoRl4wOTonQn1TT9tQbwxsa+VWs3m3WAdx8iZv/w+aIuhak
	 Ivqqy0UEt5A9LBrW9U5KFJXmVZaZUgw/EG2LRjbfLqVmeKZleNOUBiEs3eegYmRrWny1Z
	 3HIbpn98BJ1tBCnmpzPru0JLCc/zHDD4moDldOoI8N+WFTPC5R3+RT4HOcl4qVM5XeFdr
	 uHhnKMV1m30NNlxCS8YgM6NdX0TC5Q7NOND4cC/InqXbtwUydoFUN/65s2GqavyKMSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cl6fDWZ6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE7606A337
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FE7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cl6fDWZ6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so19426915e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623891; x=1794228691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZ2BPSbxMQYorksK3m6ueXVADbHpGJpfrkPqJkBaJv8=;
        b=cl6fDWZ6aqQrI1EUSkUScLu7fnlt80m7LyUQ7AL1g6qXhebFC7ipI6RGb1t5/e9T8o
         +/w1UUDZr6gKDOWS4IG6UjmY++OCNN6szxckY4PZP3MB/8oRkyV3tgbm+Shldjyw9Ib1
         sH+xtJK64PJPsrEOc4BUtWtBoE+aq+sYLbX4OTaux3ckryy9hNhiFV4BWstcSM8oqvp5
         8Q7EoTEhr3+ygJsEMqSpLuPOmj4axGxE10ekU/lMnhf2V6+MU0bGmFaBLs8do/RfY82i
         Pn+BWDD5z909gljNnuUD6aEhnYCeoAWOcg/NYXmMgwHSqnzgIIPf+Uy9wqNCwUUraccC
         ax3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623891; x=1794228691;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZ2BPSbxMQYorksK3m6ueXVADbHpGJpfrkPqJkBaJv8=;
        b=XiTJYSMLbUruy5JmKSg9sLrTkN5uspegH/fpcIyG5eH6Ytlb/+PxUYRmb1I5WkKVz5
         a0ZZapakwaU38ruAgxs+/j5JFWiSOF+eiAMgSqPWqOjxJp2fRd93clP2ERAoITYJvj54
         dGKaQyJCozJk6xv93EgZemlU40igN+PHcrujmQFquMj8mdqjVHujD9VJZOCHfelvma86
         bgEXZ0TS47kuY2YHUutFrQ1Z3360NMd2EpiABHnqMFdPjM7ZHuiXgrMCtBe7T7e524Xl
         3B4so/FiZtsNwrkrTafih17JZKby6KqIfmdDNmENqIbOkwRkd5jVgFCqxP6+dkIaOVKV
         RQJw==
X-Forwarded-Encrypted: i=1; AKwUvBxa89DtQDx+K8I6nnNwZaLv2qcXb3+6NtKg23WjCIjdbnQTPhZZ5Q2ThwqFPmLbBCtDhrKE3m8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI6HYV5qgBJBPjgHrcmeelTwVYuT3Wq+pTQldBwd9GKWD4MyRq
	8mrzMALrT6D9a/3cvXYShbotgie6CVvz7vp3VzAnbtuG6HkhzpYtTG8v
X-Gm-Gg: AYBFou2jo87yoftsrmMA8QPBfvybTt7BvSZAyd2X8m87Y/5euEa77GOGdKyhnnYUTzb
	8kGcQcKae1c7fodKKikn9O4dniYl9CQmUjatO4CXfgBQIMAsxi5OWydGmQP9eKqWObawikWCc9s
	pQdnyWlhhIC6bYmXrW2ZCrNWNwoZpLwG2a9A9+vhSUbjajnj801JUG3TrS79uC02KulJEadyWGM
	GZUWoKHhZ70nTGtD0J6rs0d9gwT6PR9WZ1Gl5gEH2yRT/P7PN6tO83B/hk4jTewuSBQk+Z3LSMf
	+NaovaPxoB5iZjANEW26q7/iJ3uCeMuN6ilHEG2KkCD6f2zs6XqdOI8jJetFKXKbOcq6v9mHeTS
	PExrOOwRMWpldAb08mANUFEfty1QOGuwRaWjDjAsx50N1fueVlfO0hXRnBBo/4hOFcRpdy/nIY8
	5bOIMjVNnvAmuZjwqo6oQIqO8P5stWR6o9a5u7lx8V8UYfnLRL01ef5lMD+dkDnl8piB7qE6GIx
	6Gnu53pk9a1Zp0Lufsmc+h/srHfuVECRGnEkX+bDBP2S6MrUzhYoJCiJQ+It1ctsd20OrxyDwR5
	rF3vciYJmdUugqDeahNqQcEWgVxAOBpTbnEeyw==
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr234213945e9.3.1793623891294;
        Mon, 02 Nov 2026 04:51:31 -0800 (PST)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm387489395e9.11.2026.11.02.04.51.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Nov 2026 04:51:30 -0800 (PST)
Date: Mon, 2 Nov 2026 13:51:25 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Dane Linssen <linssendane@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Mathias Nyman
 <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Hayes Wang
 <hayeswang@realtek.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 nic_swsd@realtek.com
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in
 endpoint
Message-ID: <20261102135125.121f8de9.michal.pecio@gmail.com>
In-Reply-To: <CAM6_QD9NDbVESP5peiNhfU5B_7UmvKVLqNz_85A_GABwDhabiw@mail.gmail.com>
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
	<CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com>
	<20260928120343.49e02c07.michal.pecio@gmail.com>
	<CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
	<20261002104355.698eaf00.michal.pecio@gmail.com>
	<CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com>
	<20261013232506.1b4dc340.michal.pecio@gmail.com>
	<CAM6_QD9NDbVESP5peiNhfU5B_7UmvKVLqNz_85A_GABwDhabiw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Adding another Realtek contact I found in r8152.c]

Hi,

I found a way to artificially produce something similar, though not
mid-operation, so there is no partly completed transfer in flight.

This patch works for the simplified case, you could try if it helps
with your issues too.

It adds usb_clear_halt() and logs its return status just in case.

The commented code is my artificial trigger. To test:

  ifconfig up
  # receive a few packets
  ifconfig down
  ethtool
  ifconfig up
  # receive another packet
  # dmesg shows "transfer errors" and "usb_clear_halt(pipe_in): 0"

The rest is xHCI changes to delay execution of URBs queued in advance
until the pipe is cleared. This keeps them from failing and may actually
be necessary under heavy RX, because a concurrently processed URB could
cause usb_clear_halt() to leave the pipe desynchronized again.

In principle drivers should unlink URBs before calling that, but xHCI
is tolerant in this case. And HCDs aren't really supposed to continue
URB execution after a halt, so that was arguably a bug anyway.

The xHCI part is written a bit "oddly" to avoid conflicts with changes
between 7.2 and 7.3 (EP_DROP_PENDING).

Regards,
Michal

---
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..e59af0e2ca1d 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7044,9 +7044,15 @@ static void rtl_work_func_t(struct work_struct *work)
 	    netif_carrier_ok(tp->netdev))
 		tasklet_schedule(&tp->tx_tl);
 
-	if (test_and_clear_bit(RX_EPROTO, &tp->flags) &&
-	    !list_empty(&tp->rx_done))
-		napi_schedule(&tp->napi);
+	if (test_and_clear_bit(RX_EPROTO, &tp->flags)) {
+		/* On USB3 the pipe won't work until we clear halt */
+		if (tp->udev->speed >= USB_SPEED_SUPER)
+			dev_info(&tp->intf->dev, "usb_clear_halt(pipe_in): %d\n",
+					usb_clear_halt(tp->udev, tp->pipe_in));
+
+		if (!list_empty(&tp->rx_done))
+			napi_schedule(&tp->napi);
+	}
 
 	mutex_unlock(&tp->control);
 
@@ -8935,6 +8941,9 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 
 	mutex_lock(&tp->control);
 
+	//dev_err(&tp->intf->dev, "breaking RX\n");
+	//usb_reset_endpoint(tp->udev, 0x81);
+
 	mii_ethtool_get_link_ksettings(&tp->mii, cmd);
 
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b634f1089bb1..25910c40ee74 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -556,6 +556,8 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
 	struct xhci_virt_ep *ep = &xhci->devs[slot_id]->eps[ep_index];
 	unsigned int ep_state = ep->ep_state;
 
+	if (ep_state & EP_WAIT_CLEAR)
+		return;
 	/* Don't ring the doorbell for this endpoint if there are pending
 	 * cancellations because we don't want to interrupt processing.
 	 * We don't want to restart any stream rings if there's a set dequeue
@@ -2563,8 +2567,15 @@ static void process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
 		    (ep->err_count++ > MAX_SOFT_RETRY) ||
-		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT)
+		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT) {
+			/* halted endpoint */
+			if (td->urb->dev->speed >= USB_SPEED_SUPER) {
+				dev_info(&td->urb->dev->dev, "waiting for ep 0x%X clear halt\n",
+						td->urb->ep->desc.bEndpointAddress);
+				ep->ep_state |= EP_WAIT_CLEAR;
+			}
 			break;
+		}
 
 		td->status = 0;
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6d997e07cb84..277911ebf65c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1855,6 +1855,8 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
 				urb->dev->slot_id, ep_index, ep->ep_state);
 		xhci_process_cancelled_tds(xhci, ep);
+	} else if (ep->ep_state & EP_WAIT_CLEAR) {
+		xhci_process_cancelled_tds(xhci, ep);
 	} else {
 		/* Otherwise, queue a new Stop Endpoint command */
 		command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
@@ -3403,7 +3405,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	/* Bail out if toggle is already being cleared by a endpoint reset */
 	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_HARD_CLEAR_TOGGLE) {
-		ep->ep_state &= ~EP_HARD_CLEAR_TOGGLE;
+		ep->ep_state &= ~(EP_HARD_CLEAR_TOGGLE | EP_WAIT_CLEAR);
 		spin_unlock_irqrestore(&xhci->lock, flags);
 		return;
 	}
@@ -3495,7 +3497,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	xhci_free_command(xhci, stop_cmd);
 	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_SOFT_CLEAR_TOGGLE)
-		ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
+		ep->ep_state &= ~(EP_SOFT_CLEAR_TOGGLE | EP_WAIT_CLEAR);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 379374a67c64..34ace464e155 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -670,6 +670,7 @@ struct xhci_virt_ep {
 	struct xhci_ring		*new_ring;
 	unsigned int			err_count;
 	unsigned int			ep_state;
+#define EP_WAIT_CLEAR		BIT(12)
 #define SET_DEQ_PENDING		BIT(0)
 #define EP_HALTED		BIT(1)	/* For stall handling */
 #define EP_STOP_CMD_PENDING	BIT(2)	/* For URB cancellation */

