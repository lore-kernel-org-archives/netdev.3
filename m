Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B53438BC
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988917; cv=pass; b=OEhuqQhY6ExJCjUgw8FbpO16FE3hXL9990QXuOOwyAaU8RQOcjti61f2p4GlRmvZwkuEbXiPmtDxjv9Kwn8ZqvSFioRtbXI0+ucxWwz42K40RBKDXI3MbTKwVjSpXrcDCtxkCpVNn7RfRqMI/mpjgm9GXXccByuJRIBhkgKSsrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988917; c=relaxed/simple;
	bh=5aR9u4NpdQGu0xWUG9HCJ0eDn30x8Ve8YDxloXGNYwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV5UZvMzQNt/3RRKFKYSaIzzBtxj3PDr0YVz0Eged9WJCAqsWNRGJ9Nbc+HqFFMyB7BAjpmYqw2dUhLOYFLJKcPuQTwSl+BWwfgidcz6d0jd40toN9HfTPwx7wPVd86FhKjAaTxluNhCt5IztC2xAHjPGmG4Pni5/aa6fy1WB8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWarzMed; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWarzMed"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so3001485b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988915; cv=none;
        d=google.com; s=arc-20260327;
        b=gUcDLOfJqpzU1qZutRITEvNd7ywjyV3YmEJwr9eUb5MAlKMdDFbVe2i/dwR/OGmMgf
         VBTZNUn6P0EVYd3P0xm3MvKAkWnP8tmQpgU8AHbQNIhLkVwUi4pfil4OSHWskpTT8GVn
         5DWf4bZlldhvuLJHUR5NkQeXp6Y5mOOnpKCxkWt0fGQRiNCwc3B8iZ3Ttd0AeEMv9iQD
         KkKXs3nO/NjWb150omQRV2yvSEgk9+rjaMf9dwVYBzgNsMEYFV2DNLpPyn1t4UYdBr8i
         +ZEOF1Zs/qBoDEpFp0ZKXSYIAOXXPHMqGsJLO3IeeXG+AjF+bBdf6t04OG0xwxR6/aTO
         yHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G6J/QMjg2Wi1vnOtRdg6KjrduusjUApAU5kKJjsUEhU=;
        fh=+rG5WxbDNyCFRD7O3tSX9HRG+/Jev7P9Ip9GL84oEkw=;
        b=r4YKgqtEiivxcq/a7t3EGSuwxssX4oOqdJef6iijjwj3UqoPeTRdB6p/kwPeHT1yFk
         lxWIVJt3KHGn8DSF6+ySe50m4FvyvGXV+cbkaMqUXbSR5rm9RIgk65BBwGsAsTDUMpNX
         etRmI93dU6US61MYj0pCkZpGv2BznRXEJ9GZbpiR2eX3p+xHpaDvWl6mI2dyD8Q7rb2k
         //Y8wt5BXSmAxpEAQu//7Sv9FrgxMe5aBUjXoykFfcNywhtBgJLEszojyU79PxwByNY1
         z/au1nRxAVHj+D9IPb69A5lMx86+m7BpVYkp25v8e9tcPcUto9UqPRn6DGBPXmLyExEo
         VX6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988915; x=1787593715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G6J/QMjg2Wi1vnOtRdg6KjrduusjUApAU5kKJjsUEhU=;
        b=kWarzMedLIVn8vsx9jTEjdMZbjoO+i0w++PqY8oA22FQBILaSP0IyrxbBQQB3fOpUF
         1yAD6c0+12P1rMGi0mINwD8DNhwaPbvSOz5+cqqBq9mOEUPhm3kQmMp9aSty9NxKlnls
         AirCoEbcR3+fSyFtTm92fQDWrwT7YrtoMx6kkiU9NZatMyHoNUJuj4iRh8dR61SDsWyM
         z2tLqkSRE7RPK3NDI6ODE3EOBGmHc7fzyjwWM6+oJFxv8kU5cdPJsfT3wnQ9bCOWz86c
         rdVdIUzil6BVuSa5Kaun+Vj3nzLBk4NyGVxHNtpPvGk8hTlpICn0cxdbK8z1u0QPvQUj
         /N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988915; x=1787593715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6J/QMjg2Wi1vnOtRdg6KjrduusjUApAU5kKJjsUEhU=;
        b=UFsjTHx2NiSm+ZnnZtfBjikpFG8KZf9mfbqkVcKEx2IEIFmyCMf9nhSTELX+Tn6Hqy
         YEORjnTwruM2zEuy8BorxOOYXP/yTEyg4cGAulWJMUDmOcPu/fmd7OM6yKITGAdi07Xt
         66jv5drxgAoL/l1B/EuixDEp+J8x+GU346UMs/8DXhIxLAbCk/pi6ZRBl7cQrSydqK10
         JMRVXLvul6aG/PnvV+PQV6yBMXEN+089NcOjYfkI6nwBvMAdn143d3WuGhdJwMNmhaA6
         RYR49wV7zmiwNqQdp/0IAz4cMpDNAdNmP1Zi/M58qzuvHXKkx3KxPcA2q1ZbYonJJA7P
         gHhA==
X-Forwarded-Encrypted: i=1; AHgh+RqXAbLxn5rDQluDpf4zP0MyL1GOorgEOx3kgBwz6OtGzaUd+DzsXYth38cOMDhw+s/yjk0aKh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NYrl9kbiOIc+pqd1h/cFXovrvssLTCgg8Ql2VhxjB0PfcAuT
	8VyN289hn5e4t9a13vvdXOjoqYbo9QHCCrdKUfsYk36VRHWnnZ5AzFVWHxBPsCa/6MXe9bZG54k
	dNeEyFrpcUROLyz2T/XZxmKwFTv3YIg0=
X-Gm-Gg: AR+sD13lGI89eJtFj2TFISxgOwx6it85TeMoNINrVC84CdIplL76jEcGJDx4JrGOv1s
	lRcPIf2iuSn4RBsrijOgK6IKydgJw5Jmp2UIx+9hggy62Xjb4oGarJ7sOAWogR6woAOoJL1/OfO
	x/6G2Lc9Yz8vG5Vccr3tKb5upHkdbSFvNYfUp67DR19bsKEQFLw4DADPMZcQlkR1qioy1C8fMyE
	Bw3uJp+0+jsbPSbeXUvdj2I6p8TSSrp4f/mxmC3GKR5/nU6kDvUFcjwbay3Tn1XbfS6ItwkBDge
	q8XHym1sLqfuIoVZFy+MEljcapTFdDLgUqNrFWggTeBqjMg5qQERr/zigxxDlm8V5zqUwYq6N9Z
	q7HCwqR/YThZSXbRSSjbCkkRnsHEtV90cXD2AhUparwk=
X-Received: by 2002:a05:6a00:1902:b0:848:7552:3d86 with SMTP id
 d2e1a72fcca58-84fde1fb61bmr25030858b3a.23.1786988914867; Mon, 17 Aug 2026
 10:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <an-oGfEatacPTSX-@v4bel>
In-Reply-To: <an-oGfEatacPTSX-@v4bel>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 17 Aug 2026 13:48:21 -0400
X-Gm-Features: AcwNN1W1hhTcPLHyV54J5TmxN5XwZW3NxDe9Dae_EV1ntIwqxabf_64Uxcrz1YU
Message-ID: <CADvbK_e60CFEVUVo25Tkcw_p4y16o8vZCf0N=hH+bUoEqpu6Qg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: drop a backlogged chunk if its transport was removed
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:43=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> sctp_rcv() resolves the transport once per packet and leaves it in
> chunk->transport. If the socket is owned by userspace the packet goes to
> the socket backlog, and sctp_add_backlog() takes a reference on that
> transport.
>
> An authenticated ASCONF DEL-IP in an earlier backlogged packet can remove
> it. sctp_assoc_rm_peer() takes the transport out of the association and
> calls sctp_transport_free(), which tags it dead and drops the reference
> the association held. The backlogged packet still holds a reference, so
> the transport stays around.
>
> The DATA chunk in that packet puts the removed transport back into
> asoc->peer.last_data_from. Once the packet is done that reference goes
> away and the transport is freed by RCU, so the next delayed SACK carries
> the pointer into the SACK chunk and sctp_outq_select_transport() reads th=
e
> freed transport's state.
>
> Drop the chunk in sctp_backlog_rcv(), next to the existing rcvr->dead
> check. The peer retransmits it. Guarding the last_data_from assignment is
> not enough, sctp_assoc_rm_peer() clears more than that one pointer and
> letting the packet run fills them in again. sctp_wait_for_sndbuf() alread=
y
> uses the dead flag this way on the send side.
>
> Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list ch=
unks in sctp_assoc_rm_peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/sctp/input.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index 864741fae4187e..83b8361d149251 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -285,9 +285,10 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_buff=
 *skb)
>
>         /* If the rcvr is dead then the association or endpoint
>          * has been deleted and we can safely drop the chunk
> -        * and refs that we are holding.
> +        * and refs that we are holding.  Same if the transport
> +        * we looked up has been removed in the meantime.
>          */
> -       if (rcvr->dead) {
> +       if (rcvr->dead || (t && t->dead)) {
>                 sctp_chunk_free(chunk);
>                 goto done;
>         }
> --
> 2.43.0
>
Can you try to move the check to sctp_inq_push() to also cover the
case Sashik reported?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/an-oGfEatacPTSX-%40v4be=
l

Thanks.
