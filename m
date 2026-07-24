Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBB377AB3
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884772; cv=none; b=AA6fhrf8oD3u6eB1xZJFvndPahEyB3MpnGIbkFmbm0YvRCPUF7sO/DOEsfXffjfDhvq1oTQSJd5tT4DOpub3eowajP98oQW6PBv3K20DUwHz8eAI6CTSsWm6IwwIbyZMMdJWdaXbMthrlt3A5DCA9fYNxeQ/qBdr/E0id5/ESF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884772; c=relaxed/simple;
	bh=PYWcOUGQI/qV+I3Sq57msatzimkkj44a6fHn4N60+/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8yvTk6VXV7Tw1tLLEBsknRkYuWB/Wj2D5n1MTkqm9CQoRiOM5h2Z8pj8uceMDS9VmkSm4x7nd8xwaAmCyIOlIz6hMLCgJoADnO7xOYGorfAvITBhTOL1ZtW+B6Isw8Tnh9zYA5JtY2Pqt0bypxjzyXnHQlKqFAEjLQ87gMngso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDHF0bON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDHF0bON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784884759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WW6AA/KhYeCHhjUnFN4/a/hB2xx19YHfi5X9x9L31wo=;
	b=fDHF0bONqikll2sciVBU8sshwZ/8VDMIyziWnN0/H2Hschy0gNmfO2EBqOiNNDlD2l0Esd
	KgdpOH3HTOKIN72rNGj0MOFKR/VAJHLJqRs2gu+udv0yDsmC5KzpgrmDkdQvFHzvf99cAV
	Wh9nLZe8FSUlexO/NMyTaAAijteZKRU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-jpUzTDYtPMmpkyEuGyllxQ-1; Fri,
 24 Jul 2026 05:19:16 -0400
X-MC-Unique: jpUzTDYtPMmpkyEuGyllxQ-1
X-Mimecast-MFC-AGG-ID: jpUzTDYtPMmpkyEuGyllxQ_1784884755
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9EBD1955DC3;
	Fri, 24 Jul 2026 09:19:14 +0000 (UTC)
Received: from thinkpad (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E39F1954227;
	Fri, 24 Jul 2026 09:19:12 +0000 (UTC)
Date: Fri, 24 Jul 2026 11:19:09 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Aravind Krishna <aravindkrishhna@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsr: prp: honor master promisc mode for local delivery
 with macvlan
Message-ID: <amMuDYQtQ5TRUJ2d@thinkpad>
References: <20260722041629.657330-1-aravindkrishhna@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722041629.657330-1-aravindkrishhna@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Aravind,

On Wed, Jul 22, 2026 at 09:46:29AM +0530, Aravind Krishna wrote:
> When running MACVLAN over PRP, packets can be expected to be delivered
> to the local stack when the PRP/HSR master is in promiscuous mode.
>
> Update local destination handling in check_local_dest() so that if the
> master device exists and has IFF_PROMISC set, the packet is marked
> PACKET_HOST and treated as local destination.
>
> This enables expected receive behavior for MACVLAN over PRP setups.
>
> Signed-off-by: Aravind-kris <aravindkrishhna@gmail.com>

Thank you for your patch! For future submissions, please follow the
netdev guidelines [1], in particular please:
- add the target tree to the subject,
- run scripts/checkpatch.pl on your patches before submission,
- follow the kernel / netdev code style (checkpatch will catch a lot of
  that but not necessarily everything).

Now, for your patch contents: IIUC, you want to create a macvlan
interface on top of an hsr interface in PRP mode. I am not sure if this
is something we should support at all. At least, it is not as simple as
forwarding all traffic to the stack. HSR and PRP both require pretty
special handling of MAC addresses. The whole hsr code relies on knowing
the MAC address of the local interface (and that is a single address at
the moment). Also, an HSR/PRP node is expected to send supervision
frames containing its address. These wouldn't be sent for the macvlan
addresses at all at the moment.

Can you go a bit into detail on what is your use case? Maybe we can make
that possible in another way. For example, the usual way to add more
"devices" (physical or virtual) behind a HSR/PRP node would be a RedBox.
We already support that for HSR and there is somebody working on support
for PRP.

Thanks,
   Felix


[1]: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  net/hsr/hsr_forward.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0774981a65c1..38ed6b09fc4a 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -589,6 +589,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
>  			     struct hsr_frame_info *frame)
>  {
> +	struct hsr_port *master;
> +
>  	if (hsr_addr_is_self(hsr, eth_hdr(skb)->h_dest)) {
>  		frame->is_local_exclusive = true;
>  		skb->pkt_type = PACKET_HOST;
> @@ -600,8 +602,24 @@ static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
>  	    skb->pkt_type == PACKET_MULTICAST ||
>  	    skb->pkt_type == PACKET_BROADCAST) {
>  		frame->is_local_dest = true;
> -	} else {
> -		frame->is_local_dest = false;
> +	}
> +	else
> +	{
> +		master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> +
> +		if (!master || !master->dev)
> +		{
> +        		frame->is_local_dest = false;
> +		}
> +		else if (master->dev->flags & IFF_PROMISC)
> +		{
> +        		skb->pkt_type = PACKET_HOST;
> +        		frame->is_local_dest = true;
> +		}
> +		else
> +		{
> +			frame->is_local_dest = false;
> +		}
>  	}
>  }
>
> --
> 2.34.1
>

