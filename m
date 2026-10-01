Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737B3E49D8;
	Thu,  1 Oct 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851305; cv=none; b=jDYxZFTEXB3A34f8j08joWZe4ZM47V4dGC/ezitwXvLfOUUW+p9r78+h0Eot36sq3LRMsDjVyTSDXcBOnp+1mjnnfdbiIaV6AyorcTySanw4bWhM2wThRjHno2/PaTr7DbnZAcbZK3Jq2SkLZF7HEke4R/xaCozc8JouKo0c8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851305; c=relaxed/simple;
	bh=2RomKtHye+dRYy79m3S6M53Ixw2KnmsBmPZIvoPkSb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+WLHM0STZYxgDvFWqsxVlIk7JcJMaP17YiCBrg5p7keACqZ7N2ayC5KHtg45Tk5yQdKaevVPP2G1/sjV9sLYLIFfxoa8k3J9MJ4H24sTTm6GVHiNEYqV7T1qq07oVCN1Upy3c+pSfU5MqeQ4R/VurzAMYh4Eic9QLCq5m+SErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1790851213te9571575
X-QQ-Originating-IP: MnVgG6vRFgIA4u0yy461TlXQhBV9IFkAyy3J+YxNQhQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Oct 2026 18:40:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 55640319989593978
EX-QQ-RecipientCnt: 11
Date: Thu, 1 Oct 2026 18:40:10 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v14 5/5] net: rnpgbe: Add link status handling
 support
Message-ID: <451DA167F36F0CCC+20261001104010.GB53018@nic-Precision-5820-Tower>
References: <FCCBC00DC4182F5F+20260928033910.1033461-1-dong100@mucse.com>
 <179082599095.434549.1820595149953223551@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179082599095.434549.1820595149953223551@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NUecTGMI9wOoqdjZb8aXtOJJFU6r25sVWGU8X2yWKafSBIAkX0XFqRkO
	+f7j/xtlWZVIwv6ASJqFfp/0RXeAwSLjeCXyEyov+3GtPm66Q8KaOMNsaGn1LmKn+U9lLCC
	kbb9KN4IoKMl5hMDopSXezqQy1ApBeDmMgZEfF8HjuVY4G7ywXdeXMXsbwoWsMlsHiKJ8uv
	wd//+MttlWPhMuY8Js5nmfBKrjk77GTKbQHkDCmD/3hQ51oaQVB60Rqhl2Qcjg20YdHWzGK
	wk0NzvdbEEMIRtCYeJ8X4nQVeEoXAkZ/UvnxktnMI29XjK+Oem/8s2V5wn1RLLfFW+NAt5H
	Wgywsray5teKjhvd2QZH/rf8ZcXgBy5QX2W7YB+rpRPi8tMl07Mesx1DjfA73G6Y/c21luS
	Dh+OGctCf1xAVHm37TgYz4ELeitgQKWmUT4yptHIlDJXQTNblg/CmMnkdGx7hdt/QVVizDw
	YerS35lbNLYatBkLGS87sX2ZC5kuYhkx+ptVlH21mBwPO94/0SftKBQ2wVBNWj2EbKt/uPR
	7NyhHQt3jrqjn3YbrQCxKNWgzYAEyqNymjc0zZ4Jr6G7zO0j7MMMBxh9kG+dptOrcC0SH50
	SqEpFYY+Yumz+FCMXFjj3XUhtZaYJOgjYhtkiY8l4DWPELRdYfyfqLngYykKBB9jRRYkS1u
	raQiCyal/cDBneE8ThHnJdVOQVi/rMJJMnxd5VhnvHdh0K50u0HjBEJN+Zi1FeeQnLfIaVW
	unjq9+Ip6wdK2dCOqQ+0bHP13SrlaeSvlgH7XFf+1YdaC945yOnCMgSKvIn0rxKCstMKtGB
	jNieXhVLLlBkcONo71JLoz/FEps7JrZ03QvjaptH8zTcSVSefyG26VF1efhZ6TcMgQCCIS5
	hMYSj6pMCXd0gtuT66sSvGRW57Qcfkc/Kur7HB2ABd3JJ/+NNlxn6772VBQyyP1f/w8gRIH
	8NldJIlzOLipqJBmmi5AjokFleIKP1/OSgvggIlutOtwFTkhR8xXZztp6gOQThe1zDUQdVu
	RtHb/FJ8BjKS14f0Ik7U0YCJqapY/Zv/VAJwb/CeCaK4lTW6fjHcMg94X50HKgfVjbvjYgC
	rjUp99+c0Bo3V2u65dfUv5lvfQOvm1XzVhP9B9D/JjNC8zZyibbiEIdKPGKHfFqVYr2tzb2
	2a/X
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Thu, Oct 01, 2026 at 03:39:50AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 1 � Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch sets a mailbox protocol: a pending firmware event
>   holds the shared FW<->PF window until the PF acks it.
> - [Low] rnpgbe_down() calls rnpgbe_set_link(hw, false) when no link event
>   is being handled.
> 
> --
> 
> net: rnpgbe: Add link status handling support
> 
> This commit adds link status handling to the rnpgbe driver. Firmware link
> change events arrive over the mailbox, and a service task updates the
> carrier state from them. Firmware is also notified of port up/down and
> link report enable/disable, and the default link is set up at probe.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > index 7beec27991d35..6f7bf4ca5b927 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > index e28f3193aa854..683e0ea741136 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> 
> [ ... ]
> 
> > +int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
> > +		       u32 speed, u32 duplex, u32 mdix_ctrl)
> > +{
> 
> [ ... ]
> 
> > +	int len, err;
> > +
> > +	len = le16_to_cpu(req.r.datalen);
> > +	mutex_lock(&hw->mbx.lock);
> > +	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> 
> [Severity: Medium]
> Should this use mucse_write_mbx_coalesce_event(), as mucse_mbx_phyup()
> and mucse_mbx_link_report() do?
> 
> The kernel-doc for mucse_mbx_event_begin() in this patch describes the
> mailbox protocol:
> 
>     Firmware releases the hardware mailbox lock before raising the event
>     interrupt and does not access the shared window again until the PF
>     acknowledges the event.
> 
> The patch also adds mucse_ack_pending_event(), so that a PF command acks
> any pending event before it writes the shared window.
> 
> PHY_LINK_SET does not do this. It goes through
> mucse_write_and_wait_ack_mbx()->mucse_write_mbx_pf(), which writes
> MUCSE_MBX_FWPF_SHM directly and never checks for a pending event.
> 
> Firmware link reporting can still be enabled at probe. rnpgbe_down() only
> warns "Fw will still report link event" when LINK_REPORT_EN=0 fails. A
> crashed or kdump'd previous kernel never runs close() at all.
> 
> Suppose firmware posts a LINK_CHANGE_EVT after mucse_mbx_reset() has
> taken its fw_req snapshot, for example because RESET_HW bounced the link.
> Would PHY_LINK_SET then overwrite the unacked event?
> 
> Under the protocol above, firmware would not process the command, and
> mucse_poll_for_ack() would time out. Probe now treats that as fatal:
> 
> rnpgbe_add_adapter()
>     err = rnpgbe_setup_default_link(hw);
>     if (err) {
>         dev_err(&pdev->dev, "Setup link failed %d\n", err);
>         goto err_powerdown;
>     }
> 
> If firmware does ack the command, the stale FW2PF count would seem to make
> the following GET_MAC_ADDRESS in mucse_fw_send_cmd_wait_resp() read the
> window straight away. It would then recover only through the opcode retry
> loop.
> 
> The existing mucse_mbx_powerup() uses the same non-coalescing path. It
> runs on remove/shutdown after close, where a failed LINK_REPORT_EN=0 could
> leave an event pending.
> 
> The driver code doesn't show whether firmware keeps link_report_en set
> across RESET_HW or a driver reload.
> 
> > +	mutex_unlock(&hw->mbx.lock);
> > +
> > +	return err;
> > +}
I think no need to handle this. rnpgbe_down only warns is because driver
should release memory for tx/rx even with a mailbox error.
After a system crash, the PCIe reset performed during system
initialization causes firmware to clear the driver-loaded, port-up and
link-event-enable states.
During a normal driver probe, mailbox synchronization is performed before
RESET_HW and PHY_LINK_SET. If an unexpected pending event prevents
mailbox synchronization, probe fails rather than continuing with an
ambiguous mailbox state. The driver does not need to distinguish whether
that failure was caused by firmware or by stale mailbox state.
Therefore, after successful synchronization and reset, no asynchronous
event can be pending when mucse_mbx_set_link() is called.
so I plan to keep the current implementation.
> 
> [ ... ]
> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
> 
