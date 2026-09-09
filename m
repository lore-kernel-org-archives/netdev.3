Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE83C9EFC;
	Wed,  9 Sep 2026 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990463; cv=none; b=NUP5bZVnLRa3eDSDNxNB0ymReH42n3aSR3qUb6H7J2B9HjvPN+qa+K6nLH+LTizUzXAOub1NU/0Nty9ZDXBbml1hfbhNWdrzMDFDm14LWMICY99H2GERKTuq001h9HhqauiYwaWO1Sq4hT8Y3XGu2PUKHqjNQ/bl44GwnaC2fsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990463; c=relaxed/simple;
	bh=PyzES/uHVDs3di3nq3fTez/4i/LkgOc9RwISRBJ8LTI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FN+9q5k3X0MTNys0LQ5OgufpUeLDIYonI2xpXUZeKumJAcQ6rCOgthGS9nH5RN8xPwnri/sj8zKtXbHtfn8ZfyYVhJJLJhH758dPzyx811Oa2xygpx2vS6BTBCHvJgHOAnNGIvkkUCPm+qQ1GsaLNAWsDbb56BTkLAPYXcB3RoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6u+QKaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6u+QKaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA2E1F000FF;
	Wed,  9 Sep 2026 21:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990455;
	bh=TxkCSwEjNOtlm2Jrz5XkAhDF93yeqvQiIMcyAnanaqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R6u+QKaVRPsDjo795RGERogcW8BlorlfyZp1m/A63WxvCkSsjQ/T4Qgpn7nycKKj3
	 QwhS0iZwP0OALvYCoQ8fKL1xwq1lgVprjMYaZbcStzWOTjGB7z/EHvT6os1MLyP6+4
	 MnYqVSn4RbzUNR2uUrPRxxUQXqWft5UcSs1ecoWUJJTi7T4otKAvh7J04VggHrjlEy
	 fcFlkfz8vz/Gm+2bAgEfkGnF9DFyy4xlkzxtIYOX7veI7hVxAt7VNIr1bf+Ihs56Wc
	 YlVE4g6AD62a6OLumyjds5UL+pImuYnTsSOxK9aov9uHBALEOEpIub08eoMAjdbRts
	 FiZQJKTBs26ag==
Subject:
 Re: [PATCH net v4] usbnet: fix smp_processor_id() use in preemptible context
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Date: Wed, 09 Sep 2026 21:47:34 +0000
Message-ID: <178899045475.219967.8804711454240391662@kernel.org>
In-Reply-To: <20260907214727.692307-1-omermetekaya0@gmail.com>
References: <20260907214727.692307-1-omermetekaya0@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] usbnet: dropping
  u64_stats_update_begin_irqsave()/u64_stats_update_end_irqrestore() in…

--

usbnet: fix smp_processor_id() use in preemptible context

This changes usbnet_skb_return() and tx_complete() to fetch the per-CPU
pcpu_sw_netstats pointer with get_cpu_ptr()/put_cpu_ptr() instead of a bare
this_cpu_ptr(), addressing a smp_processor_id()-in-preemptible-code report
from syzbot.  Along with the pointer change it also switches the seqcount
write helpers from the _irqsave variants to the plain ones.

Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a19ecf718f36a..3df72b0c6bcfc 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -325,8 +325,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
>   */
>  void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
>  {
> -	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
> -	unsigned long flags;
> +	struct pcpu_sw_netstats *stats64;
>  	int	status;
>  
>  	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
> @@ -338,10 +337,12 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
>  	if (skb->protocol == 0)
>  		skb->protocol = eth_type_trans(skb, dev->net);
>  
> -	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
> +	stats64 = get_cpu_ptr(dev->net->tstats);
> +	u64_stats_update_begin(&stats64->syncp);
>  	u64_stats_inc(&stats64->rx_packets);
>  	u64_stats_add(&stats64->rx_bytes, skb->len);
> -	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> +	u64_stats_update_end(&stats64->syncp);
> +	put_cpu_ptr(dev->net->tstats);

[Severity: High]

Does dropping the _irqsave seqcount helpers here re-open the problem that
commit 2695578b896a ("net: usbnet: fix potential deadlock on 32bit hosts")
closed?

The reported splat is about the per-CPU pointer being taken outside of a
preempt-disabled section, which get_cpu_ptr() addresses.  But get_cpu_ptr()
only disables preemption:

  include/linux/percpu-defs.h
  #define get_cpu_ptr(var)						\
  ({									\
	preempt_disable();						\
	this_cpu_ptr(var);						\
  })

so nothing masks interrupts across the seqcount write section anymore.

usbnet_skb_return() runs from usbnet_bh_work()->rx_process() (and from
usbnet_resume_rx() in BH-disabled process context), i.e. with hardirqs
enabled.  tx_complete() below is the urb->complete callback, and for host
controllers that do not set HCD_BH it is invoked straight from the
controller's hardirq handler:

  drivers/usb/core/hcd.c:usb_hcd_giveback_urb() {
	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
		__usb_hcd_giveback_urb(urb);
		return;
	}
  }

  drivers/usb/core/hcd.c:__usb_hcd_giveback_urb() {
	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
	urb->complete(urb);
	kcov_remote_stop_softirq();
  }

There is no local_irq_save() around urb->complete().  In-tree only
ehci-hcd, xhci and dwc2 set HCD_BH, so on OHCI/UHCI/musb/max3421/sl811 and
friends tx_complete() is a hardirq-context writer.

Both sites write the same object, since struct pcpu_sw_netstats has a
single u64_stats_sync shared by the rx and tx counters:

  include/linux/netdevice.h
  struct pcpu_sw_netstats {
	u64_stats_t		rx_packets;
	u64_stats_t		rx_bytes;
	u64_stats_t		tx_packets;
	u64_stats_t		tx_bytes;
	struct u64_stats_sync   syncp;
  };

On 32-bit, where u64_stats_sync is a real seqcount, can the following
nesting happen on one CPU?

  usbnet_bh_work() -> rx_process() -> usbnet_skb_return()
     u64_stats_update_begin()          /* seq odd, rx_bytes half written */
        <HCD hardirq>
        usb_hcd_giveback_urb() -> __usb_hcd_giveback_urb() -> tx_complete()
           u64_stats_update_begin()    /* seq even again */
           u64_stats_update_end()      /* seq odd */
     u64_stats_update_end()            /* seq even */

A reader coming in via dev_get_tstats64()->dev_fetch_sw_netstats() (for
example "ip -s link show") would then see an even sequence in the middle of
the outer update and accept a torn 64-bit counter without
u64_stats_fetch_retry() firing.  With lockdep on 32-bit, is this also the
"inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W}" report that 2695578b896a
removed?

This is the constraint documented in include/linux/u64_stats_sync.h:

   * 3) Write side must use the _irqsave() variant if other writers, or a reader,
   *    can be invoked from an IRQ context. On 64bit systems this variant does not
   *    disable interrupts.

Since the _irqsave variant compiles away on 64-bit, would it work to keep
it and only change the pointer acquisition?

  stats64 = get_cpu_ptr(dev->net->tstats);
  flags = u64_stats_update_begin_irqsave(&stats64->syncp);
  u64_stats_inc(&stats64->rx_packets);
  u64_stats_add(&stats64->rx_bytes, skb->len);
  u64_stats_update_end_irqrestore(&stats64->syncp, flags);
  put_cpu_ptr(dev->net->tstats);

The changelog only mentions the get_cpu_ptr()/put_cpu_ptr() conversion and
says nothing about dropping the IRQ-safe helpers; could that be spelled out
if the removal is intentional?

>  
>  	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
>  		  skb->len + sizeof(struct ethhdr), skb->protocol);
> @@ -1298,13 +1299,14 @@ static void tx_complete(struct urb *urb)
>  	struct usbnet		*dev = entry->dev;
>  
>  	if (urb->status == 0) {
> -		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
> -		unsigned long flags;
> +		struct pcpu_sw_netstats *stats64;
>  
> -		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
> +		stats64 = get_cpu_ptr(dev->net->tstats);
> +		u64_stats_update_begin(&stats64->syncp);
>  		u64_stats_add(&stats64->tx_packets, entry->packets);
>  		u64_stats_add(&stats64->tx_bytes, entry->length);
> -		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> +		u64_stats_update_end(&stats64->syncp);
> +		put_cpu_ptr(dev->net->tstats);
>  	} else {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907214727.692307-1-omermetekaya0%40gmail.com
