Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D23361640
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238266; cv=pass; b=sxwRol0dXwNzE2w35kBwbPj1ZEVWYVtkdIpUdS5sBv06wVo3whgTIhzv1giwE1CQ4OEbuAEks1uCvO1SlelVNBEgzAE/9JEgypYds3ylS8nElxwKBwHYC+cfEFSLirYqYPLan+qTR/6O3binG/5yBQ6XVv2YKtkj1k4qEEHorHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238266; c=relaxed/simple;
	bh=1VOtg2a+mCLGrBHtCxL2dQjoQpaFwsB9mKlcltTUeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixjL9sLBeSztpX7J+ZzTiyOT4hurJd2NicvnZZl+d5cx/6JixisiD6TLMCNURlQQHaukwbkqsovs/SWs4rrg8nZZEWT29s5gk8m831NbPIqGEQbxuQvLB3Yj3IVDRhd6eaQxfyRVuTXTP9sz2KLPOY8935RDzkKMWpyaf0pPGds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdpAOTUp; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdpAOTUp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1773154b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787238265; cv=none;
        d=google.com; s=arc-20260327;
        b=bLzfzAwSkRJ7n2oVTzwO/PtSm60jpNcq5PS70OVJ480LngbHa3Gzv9XkZKa6TRY4Fg
         yExhgC40Khj3wytxiNlvTNgTICGd4kZa3sNFw7w9jg8GDmDmejrFmJ4FvAAL/P2m54fp
         Hfu+Cn/CjlBd0Ac4F2h0RJEC2EyeGxWSq1VTZPLOS83GY9KNB+lMvpwus9O1WC7ve69g
         MvrHk3L0ORMsNAvTbOR173P5DOtVw0Rray4fhuHDJXRLFbdO9yg/FVH6sQCU53eEEc/e
         1BT05kvTxrTOq+Hz8Ap6iH3iV0LLBfkywqJ2aJa/r9IccroJ1SCyGrCdFbwbDT351spK
         MAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b2LmqCXxT7oGJVHwzHbpyF/RrL4Qmn8B2JsL8FziJJo=;
        fh=tIUa9X8J/BsCI4zh1mYqzmeHjLgIz7GUiwMWPbu91t4=;
        b=U3Ad+9mNbWIRecu0/ryDf4Ma8Fk96csWNkY1OQnNFM78sB7lEZ3Qd+oJcubczMitmx
         PweZBfwQ4lefOq5IzEJl3KTWQHj6BoEgAgeTLkSg5fDGjk80jOU2FRHFj6RR5BFAfel4
         JSg4FCg4gIu3T7uQX+mrrUaM3dDInejI7Xp42kg4mgTk6jQTJh0kLfd29NSGNyI6VDkC
         kamUmyUjAlsqsWH0gb3DrttA/s5FZ78bjs8cusrEYYfwIs6DfZOH4CBiFUorT8W7KPXN
         z/4jonOJ1GPuuUzZOtlP6xNwVRewS3bxoKg2J3s+Ykk3oLB9x4v/gbJLR2hx90hCs/Si
         eubQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238265; x=1787843065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b2LmqCXxT7oGJVHwzHbpyF/RrL4Qmn8B2JsL8FziJJo=;
        b=KdpAOTUp55jXdRUpUrhbN1IayzL3AGVI/8/pSteT2FXn4SR1eKuaeH89b572ogaiiH
         8JA++kuoNDXkqF8OESTUYkj6TJQGb/9eerIINm+c+TQg70FGcB/Kb/gbaP11nG3AatJy
         +EdFLr6LNSfwNIJegAFiqxxSFVsJguY6BDTDWTyzKMdSstXUvG8FIA6WAioBzK79oB2n
         ph3MgjjQtro6UvIcNvtAGUvxVzfzlNGEC9ZKyDWQd9Evkh5u5+2yDzVgQAGWYboYw7nm
         qjddpd60KR/Afq4DJrVqPHDbcrmq5k8PzlQJovxKkCWtbcIuezAMs5KMMf3SIetPPKbD
         Am3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238265; x=1787843065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2LmqCXxT7oGJVHwzHbpyF/RrL4Qmn8B2JsL8FziJJo=;
        b=M3ufRS9vq3XrDlXKwk0gFmsprIwwwyDu6IVNaRV84d37Bk6RrXQNBA//VvCEAhUyFP
         jumQj+FNJW5/BatIAn9AeycdAawFUF41c4ErkJx68bhbDP5v/tv1fmuvRTVw/gtOonER
         0k1HpZwAmF3p6dCvrFSuYbMLiLm7YsF8J7zK7OYqfxh+ydW3HJd9HfMHr4aUJszVxRky
         0bkb5Wh8v/LqAbWWx4ftxkILVDbS9jt5b0ulUTF1EcplUoi8h065cZ7c61clcMeeRBc4
         E7t9WwDkBli3DXvYJqcxSceuBRurZglHkd7Xi6eJTkfXtvt2vevtKCayyDyA6EVvawVs
         lfkg==
X-Forwarded-Encrypted: i=1; AHgh+RqDwNaoYw6obb2tP3qNNpGZawgzMuuP7O7iq3GjK2yg/zthFsi5WE2jypuXfgh1PPGK3AGVr6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxT90V0MZtQYeoTI7GQRab6JBG39EVsG5JAce2Z5D7jxag8qvK
	urIepYtrgLQJSttjxe94QrpygCJHBUpb9k1LoZ9zD56m4ZvDU9Y1kumaYTBNcZ9I7RCqfW4GZCI
	4lACIXQ5vJBo0cGRoc/Fg2Q5iNQWVBvI=
X-Gm-Gg: AR+sD12VUTEaJJauTIyiPL2zixWjE//W8vtgLOlYlUtxHlod4by5ccLv6KV+qTX/q+J
	RIWbSUXMcm2skNvH+JzIwWAZRGyo2QV4gduY/Sx6vVD/s1lPaxaX2zYURzk+41ebxHOxq2eEJvi
	4pEq1xGX7Bp7yQWIK7KSCtvUpGLMJE+mQ+JlBOPh9ePujQDKuvPvW+YSGoAIaNr8dnTcO8dSUu9
	9i0CajkkRpP2aHxcm0OXNfrCuDalHC+4yEpXE9pOzC0BQoaOcWC3fyybVtR84EMBpkhrmmHxUKl
	SoydCEk9sCkDuAWMRNl7jty0aYKAY/a65b6Posf+/9337mH1eeE7QsOma0miFs1JUuulCCuHTvE
	+ONENUw0oz2RIywcZrCOsm/i3unsnYwJraWqz+qcVBKPM9rfI1Drai8b7lpv3/IBhGq0FE87t+C
	nnlfeBmw5tqtk=
X-Received: by 2002:a05:6a00:a211:b0:845:e8b9:347 with SMTP id
 d2e1a72fcca58-851d3942b62mr21772245b3a.13.1787238264580; Thu, 20 Aug 2026
 08:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoUJHQmxL0LFIMCw@v4bel>
In-Reply-To: <aoUJHQmxL0LFIMCw@v4bel>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 20 Aug 2026 11:04:12 -0400
X-Gm-Features: AcwNN1UQX2CmBEKT0N9riqZ158JDKHJxfGAvwlOJo89EtxNcXMCDtSApxsbWigw
Message-ID: <CADvbK_cG6yTabSSEXCmEJ0MrqFG3ESHAtctupGUdRQwmeUYihQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: drop a chunk if its transport was removed
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 9:38=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> sctp_rcv() resolves the transport once per packet and leaves it in
> chunk->transport. The lookup reference, or the one sctp_add_backlog() tak=
es
> if the socket is owned by userspace, keeps it around until the chunk has
> been processed.
>
> An authenticated ASCONF DEL-IP can remove it in the meantime.
> sctp_assoc_rm_peer() takes the transport out of the association and calls
> sctp_transport_free(), which tags it dead and drops the reference the
> association held. There is a window on both paths: the packet can sit on
> the socket backlog, and on the direct path the lookup completes before
> bh_lock_sock().
>
> The DATA chunk in that packet puts the removed transport back into
> asoc->peer.last_data_from. Once the packet is done that reference goes
> away and the transport is freed by RCU, so the next delayed SACK carries
> the pointer into the SACK chunk and sctp_outq_select_transport() reads th=
e
> freed transport's state.
>
> Drop the chunk in sctp_inq_push(), next to the existing rcvr->dead check.
> Both paths reach it with the association's socket lock held. The peer
> retransmits it.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Move the check from sctp_backlog_rcv() into sctp_inq_push(), so that th=
e
> direct softirq path and the socket migration branch are covered as well.
> - Correct the Fixes tag.
> - v1: https://lore.kernel.org/all/an-oGfEatacPTSX-@v4bel/
> ---
>  net/sctp/inqueue.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index a024c08432471d..5f988b3a8814ff 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -71,8 +71,11 @@ void sctp_inq_free(struct sctp_inq *queue)
>   */
>  void sctp_inq_push(struct sctp_inq *q, struct sctp_chunk *chunk)
>  {
> -       /* Directly call the packet handling routine. */
> -       if (chunk->rcvr->dead) {
> +       /* Directly call the packet handling routine.  Drop the chunk if =
the
> +        * receiver or the transport it was looked up on is gone.
> +        */
> +       if (chunk->rcvr->dead ||
> +           (chunk->transport && chunk->transport->dead)) {
>                 sctp_chunk_free(chunk);
>                 return;
>         }
> --
> 2.43.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note, this patch fixes the case when the transport is freed before the
chunks get processed. But the pre-existing issue reported in Sashiko-claude
[1] is the case when the transport is freed while the chunks are being
processed, which is very rare, the fix would be to set chunk->transport to
NULL instead. We need to confirm and address it separately.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aoUJHQmxL0LFIMCw%40=
v4bel
