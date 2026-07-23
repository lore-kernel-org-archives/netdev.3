Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC4A33FA;
	Thu, 23 Jul 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812447; cv=none; b=A3FYVS5Z1pJTDGZPtPIPQFiArndt0AWJkVk+2UmVPxgUduAQdhGMQneMMBJFK8uMgIJYg3yQFs6RfD49nzDkVeu2I7QpcWRMs6MpmIo/kC9fJifBxroe0zz9MwxwfVCdDwklYaV40Ai3lhk4D+HRQp7L5clv2S7bK3YBdE29E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812447; c=relaxed/simple;
	bh=zDNuWJ4pbDW8CVAFrZkCntE7+LhbIksHMhV7hqrBKxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+BRKlu61R9zJfgOP15U5PU09UxIcf7zBJUVHk4VaJtDXgBjhN6lPGdJdCPi+qXBr/mPWWgyCq4FQa4bgARQ/TVZa7L0QvRqmdIGW+Cg+e83EoYue9yBSgAwY+mbV3SAFf6TDrKu26AB2134rLf6pXK/usFNLO5mq+WCJYRcWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t2EdebBm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t2EdebBm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 015AA1A11AA;
	Thu, 23 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B82E1602B8;
	Thu, 23 Jul 2026 13:13:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A52DA11C10DE9;
	Thu, 23 Jul 2026 15:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784812430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=P3Z78hR1SbZa8CzDtsIBlbG6lOPi5PvF+eqgoESLV1w=;
	b=t2EdebBmXcMg+KtvwRCNhkKszbAIBxlc70Gre6Ac4uLqsTYzEEdsyxrhOt/n8FbgxbpvAP
	fXszG4o0ouXzeLEft2nSurxjogfXGxwTXnRHem/MvJAzBWsag1Cd2aey7fnYoKEWQ1Bx/h
	ZAt4uZ9qo8SzwMsF8M3i2ZK1wtEBbjDx1k1mBCqk1PxDwVmKe3geAowATYsnVZN/CfdG3W
	o7HfaGlYSmrhLCS5fSMcvpY3yz8HdD5NJhdz7L27GkcXHmRVQXrl4gs5GoM+egIb85+k14
	8toye2XSltPPx9lvuSQNXsGFxcTRljO/4j4UErTmbKM9jm6LmBiqNGsxbaNWoA==
Message-ID: <0df6185f-fa18-4fb7-9eef-75c656495e89@bootlin.com>
Date: Thu, 23 Jul 2026 15:13:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] net: dsa: microchip: add two-steps PTP
 support for KSZ8463
To: Simon Horman <horms@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260713-ksz-new-ptp-v2-10-7209c05058ef@bootlin.com>
 <20260720140751.166805-2-horms@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260720140751.166805-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon,

On 7/20/26 4:07 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260713-ksz-new-ptp-v2-1-7209c05058ef@bootlin.com?part=10
> ---
> --- Patch [10]: [PATCH net-next v2 10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463 ---
> commit 36964d81014567278bc46ae45085179f4779f40a
> Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> Subject: net: dsa: microchip: add two-steps PTP support for KSZ8463
> 
> This patch adds L2 two-step PTP support for the KSZ8463 switch. It
> implements the get_ts_info and port_hwtstamp_set callbacks and tracks
> the last transmitted event type to read the correct timestamp register.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
>> index be6b8240ac03d..1cd2940c7befa 100644
>> --- a/drivers/net/dsa/microchip/ksz_ptp.c
>> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> [ ... ]
>> +static int ksz8463_set_hwtstamp_config(struct ksz_device *dev,
>> +				       struct ksz_port *prt,
>> +				       struct kernel_hwtstamp_config *config)
>> +{
>> +	const u16 *regs = dev->info->regs;
>> +	int ret;
>> +
>> +	if (config->flags)
>> +		return -EINVAL;
>> +
>> +	switch (config->tx_type) {
>> +	case HWTSTAMP_TX_OFF:
>> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = false;
>> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = false;
>> +		prt->hwts_tx_en = false;
>> +		break;
>> +	case HWTSTAMP_TX_ON:
>> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = true;
>> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = true;
>> +		prt->hwts_tx_en = true;
>> +
>> +		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
>> +		if (ret)
>> +			return ret;
> 
> [Severity: Medium]
> If the hardware register configuration fails, does the port software state
> remain enabled?
> 
> In ksz8463_set_hwtstamp_config(), prt->hwts_tx_en and the ts_en flag are
> set to true before attempting to write to the hardware register. If the
> hardware write fails, the function returns an error without reverting the
> software state. Could this lead to subsequent PTP packets being intercepted
> but never hardware-timestamped?

This ksz8463_set_hwtstamp_config() is largely inspired from the already 
existing ksz_set_hwtstamp_config()? Indeed if the hardware write fails, 
the ts_en flags will remain set while the hardware register isn't modified.
However, the function returns an error in that case, this error will be 
forwarded to userspace and should lead to a failure in the PTP 
initialization process.

Fixing this would imply to save the ts_en flags states at the beginning 
to be able to restore them if this hardware write fails. IMHO, it's not 
worth adding this complexity as the error is well returned and a 
hardware write failure occurring that far in the initialization is quite 
unlikely.

> 
> [ ... ]
>> +static void ksz8463_set_pdelayresp_flag(struct ksz_port *prt,
>> +					struct sk_buff *skb)
>> +{
>> +	struct ptp_header *hdr;
>> +	unsigned int type;
>> +	u8 ptp_msg_type;
>> +
>> +	if (!ksz_is_ksz8463(prt->ksz_dev))
>> +		return;
>> +
>> +	if (skb_linearize(skb))
>> +		return;
> 
> [Severity: Medium]
> If skb_linearize() fails, it returns early without updating
> prt->last_tx_is_pdelayresp. Will the caller ignore this failure and
> proceed to transmit the packet anyway?
> 
> When the hardware interrupt fires, ksz_read_ts() could use the stale flag
> from a previous packet to calculate the register offset, resulting in
> reading an incorrect timestamp.
> 

skb_linearize() only fails if no free memory is available. This is very 
unlikely, and if it happens, reading an incorrect timestamp isn't a big 
issue IMO.

>> +
>> +	type = ptp_classify_raw(skb);
>> +	if (type == PTP_CLASS_NONE)
>> +		return;
>> +
>> +	hdr = ptp_parse_header(skb, type);
>> +	if (!hdr)
>> +		return;
>> +
>> +	ptp_msg_type = ptp_get_msgtype(hdr, type);
>> +	prt->last_tx_is_pdelayresp = (ptp_msg_type == PTP_MSGTYPE_PDELAY_RESP);
>> +}
>> +
>>   void ksz_port_deferred_xmit(struct kthread_work *work)
>>   {
>>   	struct ksz_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
> [ ... ]
>>   	reinit_completion(&prt->tstamp_msg_comp);
>>   
>> +	ksz8463_set_pdelayresp_flag(prt, skb);
>> +
>>   	dsa_enqueue_skb(skb, skb->dev);
>>   
>>   	ksz_ptp_txtstamp_skb(dev, prt, clone);
> 
> [Severity: High]
> This is a pre-existing issue, but does ksz_ptp_txtstamp_skb() leak the
> cloned SKB if the wait for the TX timestamp times out?
> 
> In ksz_ptp_txtstamp_skb(), the driver blocks waiting for the hardware TX
> timestamp interrupt. If the timeout expires, the function returns early
> without freeing the clone:
> 
> static void ksz_ptp_txtstamp_skb(...) {
>      ...
>      ret = wait_for_completion_timeout(&prt->tstamp_msg_comp, ...);
>      if (!ret)
>          return;
> }
> 
> The caller ksz_port_deferred_xmit() then frees the work item, leaving the
> cloned SKB permanently leaked. Could this lead to a system memory leak?
> 

I agree on this one, I guess it deserves a separated fix to net.

> [Severity: High]
> Does the shared TX path intercept unsupported network layers for the
> KSZ8463?
> 
> The commit message notes that IPv4 and IPv6 layers aren't supported by the
> hardware. However, the shared ksz_port_txtstamp() relies on
> ptp_classify_raw() to intercept packets, which does not filter out
> IPv4/IPv6 PTP packets.
> 
> If a user sends an IPv4/IPv6 PTP packet, does the driver intercept and queue
> it for transmission, only to needlessly block the transmission worker for
> 100ms because the hardware ignores it and no interrupt will fire?
> 

ksz8463_set_hwtstamp_config() refuses HWTSTAMP_FILTER_PTP_V2_L4_EVENT so 
userspace isn't supposed to send IPv4 PTP packets. If it does, it will 
indeed block the transmission worker for 100ms but that doesn't seem a 
big deal to me, is it ?
> [Severity: High]
> This is a pre-existing issue, but can dereferencing the PTP header without
> verifying linearity cause page faults?
> 
> In the shared ksz_port_txtstamp() path, ptp_parse_header() is called to
> retrieve the PTP header, which only verifies that the header fits within
> the total SKB length.
> 
> Dereferencing this pointer in ptp_get_msgtype() without first calling
> skb_linearize() or pskb_may_pull() could result in reading past the
> linear allocation if the packet is non-linear.
> 
> [ ... ]

I also agree here but same as above, I guess it deserves a separate fix 
to net.

>>   static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
>>   {
>> -	return ksz_read32(port->ksz_dev, reg, ts);
>> +	u16 ts_reg = reg;
>> +
>> +	/**
>> +	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
>> +	 * so we have to check the nature of the latest event sent to know
>> +	 * where the timestamp is located
>> +	 */
>> +	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
>> +		ts_reg += KSZ8463_DRESP_TS_OFFSET;
>> +
>> +	return ksz_read32(port->ksz_dev, ts_reg, ts);
>>   }
> 
> [Severity: High]
> Is KSZ8463_DRESP_TS_OFFSET erroneously added to the SYNC_TS register
> address here?
> 
> The ksz_read_ts() function is used for both the DREQ interrupt and the SYNC
> interrupt. If a SYNC_MSG interrupt is processed while
> port->last_tx_is_pdelayresp happens to be true, the offset appears to be
> unconditionally added to the ts_reg. Does this cause the driver to read
> from an invalid hardware register offset?
> 

I'm not sure this would happen in real use case but I can add the check 
on ts_reg to ensure that we aren't on a SYNC packet.

> [Severity: High]
> This is a pre-existing issue, but can late TX timestamp interrupts
> mistakenly complete the wait for a subsequent, unrelated packet?
> 
> If a packet transmission times out, the worker thread moves on to queue the
> next packet and reinitializes the completion. In ksz_ptp_msg_thread_fn(),
> the interrupt handler calls complete() without verifying sequence IDs:
> 
> if (ptpmsg_irq->ts_en) {
>      ...
>      complete(&port->tstamp_msg_comp);
> }
> 
> If a delayed interrupt from the first packet arrives, could it falsely
> wake up the worker waiting for the second packet, improperly assigning
> the first packet's timestamp to the second?

The 100ms timeout feels big enough to me to not fall in this issue.


Best regards,
Bastien


