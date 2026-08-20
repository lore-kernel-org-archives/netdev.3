Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6538E5C4
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249244; cv=none; b=JamnbeQqFFRqxEyfIAYUrg0x7hghj1/wqQCsYTUtK9eX2MFWGGUni6pZeb643/f+BnQp+00GbPrxFZMiqO7Fe4ahy74rlCUkWul8pPvSc1MqewZzTTYl1iPivjPVw2eH8dZnzAkYHvA3NRNWkkjCcsZlKz+2Jm2GY7nv74S3UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249244; c=relaxed/simple;
	bh=ni3ajiGa788PkOa6kZ1AEOtext1QsSQ8nmKnd6IXZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs5sHSnrhdVMPeHs/xeDqVI9JDFoUaohYhHtCXDxBQzyVBpum5q3JAhuOlqIZacGhCmibxNBZG//mR2NB7ZaFhoHFkISeZOjOGSAItXdrfb+wNwO8Hm+jN4mOji6l3xjnRqzJAPHIfh5oPxrUznFdUXDdrNgrZfySFIZ5DDK19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNiYTEwt; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNiYTEwt"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b153acb276so179059eaf.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249240; x=1787854040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eoDlMO2HjMe2TjRXcPUA1zA1Xxgl6+t6qZXrrtvEsbA=;
        b=cNiYTEwtBZuNWZLDWnRwQGlGSYISkQaf4dpfnC/ad/XKLWypGhD+bGT5fVbDcAN9TN
         625YREsAdDWFR/15UyGsocacOtfLNMlVmxaCQoya60ef/rAJDCIkBT6q8WBdYtYW1IDB
         8hAKcpDda1BR3GKuEwIhIyAgNyYrSuZZFhp1mwkifxO7mj/gEvLm1LLHjVpIiZPQYHJL
         rvTnuKsSmVkgZ+g1hGW6UnkhRls48EaL/LgtOMrdjAYbm9wfe/oOUgrdy4ItMja3OLkU
         cJafOPrJ5ugK5s0HD563bWlBxtrXP/Jsw3V6OOSLaCx1rDrtU3/bfH7cMuodCofwQy7h
         ycFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249240; x=1787854040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoDlMO2HjMe2TjRXcPUA1zA1Xxgl6+t6qZXrrtvEsbA=;
        b=o2ulpHoGbdyza4rdbPKyoFKulStX0POVSNS6Kv5WaZmS4pWXOVjvyvcYk+TjR6xm03
         a1g4S6QPpZR+LMcEZT8duw3CGGQe+i3zVV4JI8iqnAcv/6qatUsGzm1Y7tRcs1oWlvnu
         8ewavbgYAXs0zIVbRnJdk0fsKx2FEkan2BDo4MW0iUtVYajmZ/HFcLISTLS4xC4PihE+
         rYPdXcvV8HrvTxLvyD3KcLpk8AMIhd7T5Up3MFZ5/iKB3UKetVBNX/clYhsyQAcH7DXg
         1MnmjmPmBgwyxYBb3qKqOm5XsnSWzyRbg9xcfw2W2wXRrB5EOJByEnEI+PzGYqnsgQXb
         T+NA==
X-Gm-Message-State: AOJu0YztburuIe7zEe0C9G2TznWIZavZU/hQLGESI9URo+9anBUtq6xV
	lddkGzFGSkqKm7kLvf82AajB3wA6CQTyiPlCWfEOL5NiRe5bKdB4VLtN
X-Gm-Gg: AR+sD13Q6Cs1tM4cPcmlH6vHF3eYWFLA0mE3CutBh5Ht3PYVzJfdFuZhfvRLFdWyFv2
	V78xosdSnxIveZ+qSAWoVGeHhvibNXhDYK9O/OwVQs2llzEcXNq/LQHwoa9aKd8nUWieBK5nPZs
	qEFlHjn4aGczx6BiR34kMorEjt97n4DfWGNSMjAhcpICk5A62o+G0PMbVj5cwazSFEnq4Iuqhg7
	LnIFkugsRgbsDwCwwQFkKQcuj7QN4WB8L9PcGVbHljpIYttoB9hmBWQhi+TjEKZhMPVBWL4xksA
	VFiblcuU2jGUpaneeqIejrECUXXqSb7m9ZsxvR8DgayVEebUtkkLIdzfEG1AwJXBOTNmpj3RCy4
	tKFfGIqanI2W/1ZoZx8v43Hovm2J4hCgrs/xauWMrEqKVEaewvL7a0828qWdeuxaswbmPFlk58M
	kjQx+Hk0uPu4/+kKrYH2fMVmc7pOlhh/TBKOg5SaJdiJMxn6+MBO19al/fb0WIvkEGS5e4OXgcx
	0sN7fsp
X-Received: by 2002:a05:6820:200a:b0:6ab:13:b207 with SMTP id 006d021491bc7-6b1593ee12cmr572636eaf.27.1787249240224;
        Thu, 20 Aug 2026 11:07:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf065d3sm5797270eaf.12.2026.08.20.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:07:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:07:16 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: validate packet source for
 connected sockets
Message-ID: <aodCVDNMDPhxw45G@devvm29614.prn0.facebook.com>
References: <20260820001517.2148196-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820001517.2148196-1-4ncienth@gmail.com>

On Thu, Aug 20, 2026 at 09:15:17AM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() looks up sockets first by the full source and
> destination tuple, then by destination only in the bound table.  The
> fallback is needed for listening and connecting sockets, but sockets remain
> in the bound table after connect(), so it can also return a non-listening
> socket.
> 
> The fallback does not validate the source address.  In TCP_SYN_SENT, a
> RESPONSE from an unrelated source can transition the victim socket to
> TCP_ESTABLISHED while its stored remote address remains unchanged.
> Subsequent RW packets from that source are delivered through the same
> destination-only fallback.
> 
> This was reproduced with capability-empty processes under different UIDs.
> The attacker discovered the target tuple through unprivileged AF_VSOCK
> sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
> the intended peer-side socket read 0 of those 16 bytes.
> 
> After lock_sock(), reject packets for non-listening sockets unless their
> source port matches the stored remote port.  Require the CID to match too,
> except that the loopback transport uses VMADDR_CID_LOCAL as the packet
> source for connections addressed through its valid CID aliases.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes in v2:
> - Preserve valid loopback CID aliases by matching the source port and
>   accepting VMADDR_CID_LOCAL only for the loopback transport.
> - Rewrite the commit message and receive-path comment for clarity.
> 
> v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
> 
>  net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8becad812..d8990f5f6 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
>  	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>  }
>  
> +static bool virtio_transport_source_matches(const struct virtio_transport *t,
> +					    const struct sockaddr_vm *src,
> +					    const struct sockaddr_vm *remote)
> +{
> +	if (src->svm_port != remote->svm_port)
> +		return false;
> +
> +	if (src->svm_cid == remote->svm_cid)
> +		return true;
> +
> +	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
> +	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
> +	       src->svm_cid == VMADDR_CID_LOCAL;

nit: not a strong preference, but I feel this comes out a little more
readable as:

	return src->svm_cid == t->transport.get_local_cid(); 

Otherwise, all looks good to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

> +}
> +
>  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>   * lock.
>   */
> @@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	lock_sock(sk);
>  
>  	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 * lock_sock (note: listener sockets are not assigned to any transport).
> +	 * The bound-table fallback matches only the destination, so reject packets
> +	 * from a peer other than the one stored in the socket.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     (vsk->transport != &t->transport ||
> +	      !virtio_transport_source_matches(t, &src,
> +					       &vsk->remote_addr)))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
>  		release_sock(sk);
>  		sock_put(sk);
> 
> base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
> -- 
> 2.54.0
