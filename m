Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB737C0E6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735525; cv=none; b=ZeHWxVdvPUr3lTD0kVC9pJW1gQTUJ2Zlod3llxFXqxgtF4KWHy5aSt7zDeBUpMynYrIVlJda/fNJM9or7Lqxs3jsclQN/lgMjTavVVBMxldCS8RDwgwve34GBeIcl9aNt6pZ4Whd7pY2Y23kkAcwt2lAkruvX4iBH/peLCc7al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735525; c=relaxed/simple;
	bh=EUXyf5mwwMyFeXqt+QNbeLD5iU2yeBaCs9BxvRnFt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6duDGjhvFtlf2zza4yzM/oc39m++HvmkV3eD7A7Qv2kzDsERECiD2uLgvp/je8XcuS0EJu9SJGTeb/zX048G6nx3oL6+vDiIrxwx1ECbSYlFI7j5Q1A5MWD+Yd5vbdoML+mNeanaw/17QlYTkpKr4DZ85sYIOj9YlKhuSGV7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7e8O5QH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tVM+PQ9O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7e8O5QH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tVM+PQ9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789735515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNHbAwEuVi2IzpLwoXGz7v+aIL/8hFsG5BvN11sltgw=;
	b=R7e8O5QHLcw0ZmESRz2iqv4lrdIUbfHVEUlQ3uvDWBVu5SXmQuA0j9gx2lUyVRKEtJZTzB
	Ty+iJITxGzzKE730EEejXHFrBzCUNvXlUtwlb7nGYa6baKns89zDBCdOO7EGttlpz7dVCx
	pNpElBkkZBpC6vXajxuEpiT/2vbqlHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-2QgmC2YhPtC3a1Rj3SaFTQ-1; Fri, 18 Sep 2026 08:45:11 -0400
X-MC-Unique: 2QgmC2YhPtC3a1Rj3SaFTQ-1
X-Mimecast-MFC-AGG-ID: 2QgmC2YhPtC3a1Rj3SaFTQ_1789735511
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f18da958so460285f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789735511; x=1790340311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNHbAwEuVi2IzpLwoXGz7v+aIL/8hFsG5BvN11sltgw=;
        b=tVM+PQ9OjsvnYxvSjOUPDr7gVF3Z/Koz67jvUShUCOStcMESQu5qa+UQseoqwX7a9T
         rCeF4wPbHwnNAk7z+ac4QwmKW0McjhiGiAoetSaC6bTzku9HhBToiMsjdVdQCxX6Bys7
         F2kNrvQ/5kQdL4uUW82CbGNEc5HDVJTv64SSLk6IEoyESKBtoQmdcq/2g6yZXqNAsw+H
         +fTO1ukFUKH7tKom87tHfzv4JKHv7HavIwmbXRecoLXzarFGoxpGXhVOW28ae1gTSAeu
         +uRUDrRGFPe7TXJdsJFvNl8BXGqx70/UTzUIi4Nzu51VdcfOJ8W+NrlWfEn80xEXaQuq
         KS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735511; x=1790340311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gNHbAwEuVi2IzpLwoXGz7v+aIL/8hFsG5BvN11sltgw=;
        b=No9A/rS0Py/YNAUBcZFwgD21tQjOjbLbcgKv2swZOgQN9XLToIFnvdPuEGepxe2XLp
         T5007DlPLywOyaf49FybyB3rx6p3XkyqOgmQlzPGkreyLvj+KJqIvW7YDhqdKM8QgyoT
         2zZa6KzLLmUAkxWHkELA4RxuAOkHnj4C4mwShWFTWXRopavWUeD63OAGIwyR4pZlTfKv
         pyrVCrz7KDhbdLsfasxSR4qSeXQ7xZwBD9ILT3x5QiQQG/6WCIFW3TQE7ZzOm4k4Jt4e
         CPiGPX/jwYDSoPKN5Hit4Ai/hs1X9pn4LkPnEkkhCERtjfpPH9nmRDWRWDDMz0SzHy6y
         L2og==
X-Forwarded-Encrypted: i=1; AKwUvBwz2naYPT/rwLdiJ8XtSQqlV6gNRD3ivfPGtjMRnqojqqKT3+xpCShJ8PLx3u6cyI82Gc8GUY4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ5/kAkjq61OUxR3M0hBiuYl9sqf4ZwvXuBqj1F8UKzHyiR4zZ
	6YyLJpfD3oYnRDBH1IEBjGvHd92oX85SlR3KKjLRFPdLbG++E4FRPrWWRPFdcrPiFR4jVsDtO9f
	NZbPJa9tHLHZ4aeAea4AIPqKTpGrVWaWXpUgok/Z/RCTlzbV/lSO8dlY+og==
X-Gm-Gg: AYBFou1pIZ/E/HReN1M2B4FxHusTp2/Q5kE4ZIWW4vydwX2zcVdbVHUe7krjNeiFvsm
	pH/CCsSThsHVAegIycoZbq43v2SiBvUekTVZuGULLaEkZWgPzmd+tJk2SFcDPVa2gaTR/XZVmgk
	oO/61uCZe4woqGg9KAlYZjc9+eOf53Kps+i7YTSutfhO/FSOUYWE9pOVImFjrouk1TxG/I9VBrx
	2N6/8SkCGhs4naIoRBUlkAUVC6FpgZFQhZxEXweL5DHsTE8j3j8bHLaF32nhMWzGfqr4gq9qOqe
	r6iZuPVR+ibR0XBAkW2NoVCRyWSiqPsPOmKk913zKdtEgs4InGY51PtBg5Nu1rrgD9aXWzgxNPH
	9fSoIrj48t3J96C70urc3NFf96MG3i8ooGnixU583YzU20A==
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id ffacd0b85a97d-4871d98cc80mr4209369f8f.3.1789735510714;
        Fri, 18 Sep 2026 05:45:10 -0700 (PDT)
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id ffacd0b85a97d-4871d98cc80mr4209343f8f.3.1789735510256;
        Fri, 18 Sep 2026 05:45:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48720078bfcsm3821644f8f.28.2026.09.18.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:45:09 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:45:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, pv-drivers.linux@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>, bobbyeshleman@meta.com
Subject: Re: [PATCH] vsock/vmci: harden datagram receive access check (netns
 bypass + cached_peer race)
Message-ID: <aq0xcAKg1snndtdX@sgarzare-redhat>
References: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>

On Fri, Sep 18, 2026 at 12:02:24AM +0200, Bartłomiej Dmitruk wrote:
>vmci_transport_allow_dgram() gates delivery of incoming VMCI datagrams. It
>has two problems, both in this one function, fixed together here.
>
>1. Namespace bypass: the send hook vmci_transport_dgram_allow() refuses
>   datagrams when the socket's netns is not in global mode
>   (vsock_net_mode_global()), but the receive path never checks it. A socket
>   bound in a non-global (local) netns therefore receives datagrams from
>   peers it could never send to, defeating namespace isolation.

Is the VMCI transport supporting namespaces? (CCing Bobby)

>
>2. Data race / stale ACL: the decision was cached in vsock->cached_peer and
>   vsock->cached_peer_allow_dgram with an unsynchronized check-then-set.
>   The function is called both from the lockless receive tasklet
>   (vmci_transport_recv_dgram_cb(), no socket lock) and from the lock_sock()
>   send path; lock_sock() does not exclude bottom halves, so the two contexts
>   race on those fields. An interleave can return a stale 'allow' for a
>   VMCI_PRIVILEGE_FLAG_RESTRICTED peer (and it is a plain data race
>   regardless). The in-code comment claiming the fields are never modified
>   outside create/destruct is contradicted by the send path.

2 issues -> 2 fixes, no?

In this case mainly to backport them properly, since for example we 
added namespace support only recently.

Please also add the right Fixes tag and all maintainers in CC.

Stefano

>
>Add the symmetric net-mode check and drop the cache, evaluating the decision
>on every datagram; there is no shared mutable state left to race. The now
>unused cached_peer{,_allow_dgram} members can be removed in a follow-up.
>
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -529,18 +529,25 @@
> 	if (VMADDR_CID_HYPERVISOR == peer_cid)
> 		return true;
>
>-	if (vsock->cached_peer != peer_cid) {
>-		vsock->cached_peer = peer_cid;
>-		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
>-		    (vmci_context_get_priv_flags(peer_cid) &
>-		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
>-			vsock->cached_peer_allow_dgram = false;
>-		} else {
>-			vsock->cached_peer_allow_dgram = true;
>-		}
>-	}
>+	/* Enforce the per-netns mode on the receive path, symmetrically with
>+	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
>+	 * (local) netns must not receive datagrams it could never send.
>+	 */
>+	if (!vsock_net_mode_global(vsock))
>+		return false;
>
>-	return vsock->cached_peer_allow_dgram;
>+	/* Evaluate on every datagram instead of caching the decision in
>+	 * vsock->cached_peer{,_allow_dgram}: those fields were an
>+	 * unsynchronized check-then-set shared between the lockless receive
>+	 * tasklet and the lock_sock() send path, which could return a stale
>+	 * 'allow' for a restricted peer.
>+	 */
>+	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
>+	    (vmci_context_get_priv_flags(peer_cid) &
>+	     VMCI_PRIVILEGE_FLAG_RESTRICTED))
>+		return false;
>+
>+	return true;
> }
>
> static int
>

