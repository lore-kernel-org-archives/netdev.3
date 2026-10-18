Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501403F824D
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298595; cv=pass; b=XaeorUkWVehQydIrxyjEpw2AGsOb/tncNMCo5jMnIARdGRO5T3hYbG0cUqMmrui9sWO8bFS308FEeG8FEcrsKXz/AxBNKCUQdwmvgPoOe0uNKwyXyETnK93pnIwTtwdBG9Jrh7KXWRbYMfTlxOclEO/0AzvoTkD6jkwECYjCRxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298595; c=relaxed/simple;
	bh=DHpt0emLBDEXhg01inCWP8u2BhRmbxlc7aC04HKyBeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWrHGQUO6400/UAsS6G1EuccB6CFQHhLZdbVdn7Rn3ItQogI7F8gGVDZniDPMBGnQS9Zra8gyEd5g8Tq2mmiHYNkJxQGq23b0kF94tgbr+qJ27F5eM4OTI8YG59U6bSYR+wtzJJWB9PdXFPNTHq7bBLAzBRtcnqqU/DQP7LfJtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QazQzvUt; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QazQzvUt"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b83459526so14949116d6.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 21:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792298587; cv=none;
        d=google.com; s=arc-20260327;
        b=J2ZiD5kmLkGYo7hOMM5y2sIz4VVmfAKg7wD58PS0J7FiZlFQGLP02aS1wG/TzAeyj5
         hfZH60sOcEe54CNRjJnRZ4qQjpJnRYD/NeT7yD8L64GfY6Pp7Gd6uYi9ITAZv+QiQejQ
         gNZhbHg9qnc4SksHHDCPMbgrm00TsgGQ7t3T5V4i5RZqgSSbLJJm0vXFs09I49w2QQye
         uKWZrkuAJqX/HpwbIrcMtcVQplA6H5dvyvlW7pk0jV0K0I49iyAyCUatb6ZbYVHbuVfi
         uV9fhIcckibkR1X6cpYGzXuvFxDAWTNmkZ1uia1trQN14mRcxsaQa+4NaleSFYnWL3wR
         qTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        fh=RSVrTET9mPHU4yEI7pKk/0e0nqikMFOv6PiG1Q9rpJ4=;
        b=SeObuXsD18SB+3HJY53FXlA05ioiZcl0GITSva3ocDDgPHyGncpxK68mfIOJRbFVcO
         MtocYjnD6v40SfhLIGfa1Mo9nQhOBAVOze5q5LFe+22RS9+ekKnenwdjCRQ3J0TODY6/
         SP85VLX8Y3sCRs/M/Aa8BzTXU4SxCupwAXAHTdOWqEKEeRLwzaLp/0k2NniaiRZ2bnLD
         MX138NTu/9AugexkErLO0X+ohIRqefNQ64PuA0xI4Wse9XIrMM/WmFon/Le4EhMWUrl+
         zBynAj8/v3txpD0jP3B1qbBq4QhLh/rIhsMmmcYycmnZbZJRX1dEO53uc0p5TXSoTOTy
         rN8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792298587; x=1792903387; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=QazQzvUtDkxjlnkXd7Dc4Q3ge6a0E9Pcu+129KI0o3/+btcboUKlA5M+F3R66tDPct
         vjIr5eHi8LF8GQC+EY2834iNwUJ04ZhqapiuflLdS+eFnWma9oSqPwY+Iti2pDrIqyeN
         p3Ukamag+aGoIHuVcKRjMS/DUi3d297CdwhomOiGoQ1gfZuYRO0KcpT+Yy1aH4WVjvK8
         +YfwXfy8LUOAGcZ/o11Kc15e261H2tcNh+LGf96etmOkUrUIJSf3ek5jYyHgSQxVvSYh
         Byq8qqDo/IT3s7Q8itFIdYR+G3VF9JMNCPIPBVEg+bN3EY7cx5rIRJ4xWSrHd78FzRNu
         R43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298587; x=1792903387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=KwLcy2iQCsXKwfm5rQqqxzK6J19CQf/fa6udK66nEH39NP8oMRoXD4vwMwKvvYD9CR
         smoGpGSFUMkhp3JMwIuD7HnSBwmEiv2rfodCFXXHFDphU33WeL/A+GK0pb0nE92oFC/a
         2G4bqVBSf473HeY2wZe/YA4mLLOkCi1DxZds1NhD2MJHXVbpeou9M+tJElAj5N6quIZ+
         lVQtVhRPO12cLcH1IgKN8TQNaS91yH73YaUnGHnbcYiBYay3nJtFGy8uLZ9vPQCpDuy2
         inCwyQ8+HWp+uvNj7TFclNHHJr1hgPYhu1XFI3mBdelA6kEPfG/XuLgq+1pu5L657VG0
         28nw==
X-Forwarded-Encrypted: i=1; AKwUvBz2fTF1Emfe1NNYKZBF0y9fGcSrhpgBd4L/G0Trxsd+G931bmGTts4ihB/t7CeZk0SqWa5LVxU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxLd5kkCc5IDvohxhn5hGWZYMYfEyDKuz2t11ys17jpLdsg6NH
	GSCyH0LVMrE0pGg6du+emVUzPat2sLvdOxmtlSXFHcrjsQjLf32XBbVSsWGieEoaD1ZZFizTPcl
	RYXEn+1x6k7hCNjNQtvO2OOZG5Nj+I4o=
X-Gm-Gg: AYBFou2qWCy6AAVZldMBmsvs/iFGdqdjQz+NG/8zTqZJUDhOV/ABDzaw/hkbrLAupz3
	gm/NgL2rwhCRaxuyHhmFonBoAwF00ny2trdI65YzW/CRv9PQdkrP73EiBx2vqog9Gr4+6zMPbyW
	FPRoQHloE3Jd3WpuFCLIKuqKoJgyvfEAvz5+LJKEgKMcofvt4qn/Q9ll6VT3xgmU7GyfXx4m0T8
	j6wqvGisPnnggoCHA2t7y9UBKR49lIgnZWh57HNxzaNzvh5GZcuFQFWTiTBt+XbTeAXfzlxspIj
	XYg05DbGsKjJTZH0DsG7+PYikmmA2pexl6/gPAW6HcOIbG7S/5ofva4=
X-Received: by 2002:a05:620a:260a:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93f299f3829mr676090985a.0.1792298586112; Sat, 17 Oct 2026
 21:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com> <atImp74JbTbEb0d_@sgarzare-redhat>
In-Reply-To: <atImp74JbTbEb0d_@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:42:29 +0800
X-Gm-Features: AclHuK8Ob-l6fq4mltZ_vIa4jBsMb_PwAPuMxfSzbBTGRIF1RfJPYptCeSCMlpA
Message-ID: <CAJwVaML2F6vN5xGsmvd1PwD3ToLOeV_PfzJrArvan8gvbveKuA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
> >Split virtio_transport_recv_pkt() so socket lookup is separate from
> >receive state machine processing under the socket lock. This prepares the
> >receive path to keep a looked-up socket across multiple packets in a later
> >change.
> >
> >Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> >The locked helper obtains packet-specific addresses from the skb and uses
> >the matched socket namespace for reset replies. Preserve source validation
> >and failure handling.
> >
> >No functional change intended.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> > 1 file changed, 75 insertions(+), 53 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index f225f53ed4bab..61ee3bc205d5d 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > }
> >
> >-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >- * lock.
> >- */
> >-void virtio_transport_recv_pkt(struct virtio_transport *t,
> >-                             struct sk_buff *skb, struct net *net)
> >+static struct sock *
> >+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> >+                           struct sockaddr_vm *dst, struct net *net)
> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >-      struct sockaddr_vm src, dst;
> >-      struct vsock_sock *vsk;
> >       struct sock *sk;
> >-      bool space_available;
> >-
> >-      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >-                      le32_to_cpu(hdr->src_port));
> >-      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >-                      le32_to_cpu(hdr->dst_port));
> >-
> >-      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >-                                      dst.svm_cid, dst.svm_port,
> >-                                      le32_to_cpu(hdr->len),
> >-                                      le16_to_cpu(hdr->type),
> >-                                      le16_to_cpu(hdr->op),
> >-                                      le32_to_cpu(hdr->flags),
> >-                                      le32_to_cpu(hdr->buf_alloc),
> >-                                      le32_to_cpu(hdr->fwd_cnt));
> >
> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              goto free_pkt;
> >-      }
> >+      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> >+              return NULL;
> >
> >-      /* The socket must be in connected or bound table
> >-       * otherwise send reset back
> >-       */
> >-      sk = vsock_find_connected_socket_net(&src, &dst, net);
> >-      if (!sk) {
> >-              sk = vsock_find_bound_socket_net(&dst, net);
> >-              if (!sk) {
> >-                      (void)virtio_transport_reset_no_sock(t, skb, net);
> >-                      goto free_pkt;
> >-              }
> >-      }
> >+      sk = vsock_find_connected_socket_net(src, dst, net);
> >+      if (!sk)
> >+              sk = vsock_find_bound_socket_net(dst, net);
> >+      if (!sk)
> >+              return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> >-              goto free_pkt;
> >+              return NULL;
> >       }
> >
> >-      if (!skb_set_owner_sk_safe(skb, sk)) {
> >-              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >-              goto free_pkt;
> >-      }
> >+      return sk;
> >+}
> >
> >-      vsk = vsock_sk(sk);
> >+/*
> >+ * The caller holds sk's socket lock and must free skb if this returns true.
>
> Why the skb must be freed by the caller and not by this function itself?
>

You're right, it doesn't have to be. I originally left the skb cleanup
to the caller so it could unwind either per-packet or batch state
while preserving
the existing error-path order (release_sock() -> drop the lookup
reference -> kfree_skb()).

However, that distinction does not require skb ownership to escape the
helper, and the resulting ownership contract is confusing since the
other paths
consume the skb internally. I'll make the helper consume it directly in v5.


> >+ */
> >+static bool
> >+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >+                               struct sk_buff *skb, struct sock *sk)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src;
> >+      struct vsock_sock *vsk = vsock_sk(sk);
> >+      bool space_available;
>
> Please, follow the netdev convection for ordering local variables:
> https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>

Sorry about that. You had pointed me to this guideline before, and I
missed this during the final preparation. That's entirely my
oversight, and I will fix the declaration ordering throughout the
series in v5.


> >
> >-      lock_sock(sk);
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >
> >-      /* Check if sk has been closed or assigned to another transport before
> >-       * lock_sock (note: listener sockets are not assigned to any transport)
> >+      /* Listener sockets accept packets from any source and are not assigned to
> >+       * a transport.
> >        */
>
> Why changing this comment in this commit?
>
> Oh because we moved out lock_sock, right?
>
> I think we should keep in some way the old info that was much more
> informative that the current comment that just say what the check is
> doing and not why.
>

Yes, I changed it because lock_sock() moved to the caller, so the old
wording no longer read clearly at that location. But I over-shortened
it and dropped the important reason for the recheck. I'll restore that
explanation:


> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> >            !vsock_check_source(vsk, &t->transport, &src))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              release_sock(sk);
> >-              sock_put(sk);
> >-              goto free_pkt;
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>
> We need to be careful here, IIRC Bobby used the net from the caller for
> a reason.
>
> Are you sure it's fine this change? Why not passing net as parameter and
> minimize changes?
>

I assumed sock_net(sk) was interchangeable with the caller's net after
a successful lookup, but I took that equivalence for granted. I'll
change this in v5.

> >+              return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> >-              vsk->local_addr.svm_cid = dst.svm_cid;
> >+              vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> >@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               kfree_skb(skb);
> >               break;
> >       default:
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               kfree_skb(skb);
> >               break;
> >       }
> >
> >+      return false;
> >+}
> >+
> >+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >+ * lock.
> >+ */
> >+void virtio_transport_recv_pkt(struct virtio_transport *t,
> >+                             struct sk_buff *skb, struct net *net)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src, dst;
> >+      struct sock *sk;
> >+      bool free_pkt;
> >+
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >+      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >+                      le32_to_cpu(hdr->dst_port));
> >+
> >+      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >+                                      dst.svm_cid, dst.svm_port,
> >+                                      le32_to_cpu(hdr->len),
> >+                                      le16_to_cpu(hdr->type),
> >+                                      le16_to_cpu(hdr->op),
> >+                                      le32_to_cpu(hdr->flags),
> >+                                      le32_to_cpu(hdr->buf_alloc),
> >+                                      le32_to_cpu(hdr->fwd_cnt));
> >+
> >+      sk = virtio_transport_find_socket(skb, &src, &dst, net);
> >+      if (!sk) {
> >+              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              goto free_pkt;
> >+      }
> >+
> >+      if (!skb_set_owner_sk_safe(skb, sk)) {
> >+              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+              goto free_pkt;
> >+      }
> >+
> >+      lock_sock(sk);
> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> >+      if (free_pkt)
> >+              kfree_skb(skb);
> >       return;
> >
> > free_pkt:
> >--
> >2.53.0
> >
>
