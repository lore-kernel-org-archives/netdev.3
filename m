Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7853E319
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114262; cv=pass; b=s8UQRAwALMn2nOj3QIr5kxSUgdCZ70h8ddvcOyjPHAFGev+f6t62ObZ3nikbC4M6s32KoZea4tAZEI82Wurk2v7YK6ygmhImcDXZFmh4MffMlfNIBMamGciGNep3YaEG6lbn9YzX9ViKpjAH52epEKBoFTIYg4LJbXcMWeNat/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114262; c=relaxed/simple;
	bh=CO3As2TmPZjHhrml1U6HFpp8ONG/W6yW1foBj5kICTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeufkFMjsDVW/wD+cTGot68LaZp7fKf/NDBJjeEwSlKL1RiRIT33/OidRETcaXL1Xt8tAFwcWKgPeBu/O56zO/KQCvDGJ2zRuue6JPix9TMUnptEwl67jEJDoPL8KnfjfsAU8CoX9KbNMbAwDGnn3DEsx3w0LNGyLuQwfrZBWMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us5TBGfs; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us5TBGfs"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc433d52421so225134a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790114252; cv=none;
        d=google.com; s=arc-20260327;
        b=clSILxaIOp3jbnU27emhRR4/6GpHQFVXuUn7RcJshN57emInH293Qv/M6wEPBcyjxJ
         PAPJPXJ7rnK22z8Dn4NlZecLQpQUmOU+V5Nx2TBVMBvUOm8YSpiRhqWzkEtCcdMaAtr6
         iJdesqtgjh0pi2UZKVEhK0BwaoQBir5ggKAyiRcV5cNN2VZQpK5mEN/Zq4zMneivshEy
         esUeWQ2dBuefFpybIFwAFfiS5kpNTNpq8jFZNcKzgklCMYS9EGhTPrPo2R78NCXxWw5/
         G7ICa365B3ScwTviQ55eAvtUfHEPG97GC2/1Jy802OygprvHGi4fLbrS4a1FDYE/hV9g
         oLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        fh=ruQiqgY/kKwNRaDZz/bdZNi9zddru4X3tyJLV3ySLzE=;
        b=TUTijgxIelHAH3DoHd1/ixW+s95V7PHfXH5oRyVPkgZl68vK7rDaD9IpT8DNahcqYA
         cNE4LYgHC8A8FMH1NO5sW2B/JE/RnjiYmOTNejscUoavFRm9b0xNK0+I5SN++/peVumG
         1srvK4GrSRGRQcAz8iLC7KpbEuggdvFEFEBvUh6Ef81t1O75OK2CEmh6uKLWXsj1w5vP
         gx7AB3JWD9xTh2NwrEIjWwEOt2BOSljesG3Hu9JUiFIEzEbpP/6TgpbvT+FGolMLFkIZ
         MIIfM8PR1kk9eEamEtsayz2tCQ+/Fbx2wjGwRkWyTwGFmQDKWfzeqpotSgD3KcSrM+s3
         q3Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114252; x=1790719052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        b=Us5TBGfs3qeUoDvHlwFmC+tSk+tOUiIYUmkdxk1M782cBUKM4Qf0A7UehHiYOfZJ5v
         0Kz9TqdS3FH7E2gtjnYuhgiIv6FoIR14bvBhNZSSm6kVEbJeIHgWR9ENHw2p3OFUy+ld
         8lrM/oIl8ubdqz3YLpsJMvr7bFyr+XbJ56HfEXMyxgIHLuOSZ60QJvPqt6RA/+z0+9DO
         49Nqgnib+bSy9rw0ALx2Q33lDChp0cFdhmy7HKN6xZOxAgpDCVZJwj/amL2cD3NbmNhN
         BFm8ilOSy2mZsmMcGxvASomAh05FBM3D+WTZW+s3vs07/1Gjcz40EeBpG7HIM7iN1F0L
         1qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114252; x=1790719052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        b=z8GQ28ZNc9FldbEqQPO+p0Tbo0uRdsM7Y6lB9FxIOj7WQy/JOPESY7/1cLZUal55Cm
         jd+OVYEa1gssgOM1yGQZqEXUDW+8MWQQHFOTpkJVtiWikwlAad1tCUnRDpr17vaiz4vO
         PM4Wa54MmrRjdcvaxTG1T047QjO53yFwIJZBRg4RHOeR4eFji8suvE8zhmFPFac1E4fe
         LJjffAfe4HS6eHyj9kszlxIBNtg/nMxiv17M7lOXqfU2q9OP+bD3RG0J0/J5DGYgyQYU
         P50XJvfW0RrHsu3zyy9HVToeGR6tzE7PgM7R+eSk18B/hB+4McSeTTYIgMAiW0rKvUnD
         j24w==
X-Gm-Message-State: AFuF++kTf5PQkF3DtTuRL37uofsjQHoap79SsvOiq8ksAHtZzFkCdpGh
	Cpn2HBsVbuC1CGVCgqnopjbEFuTVnMwTrG+ASHx8sC2NT4y1Q46xys9hmttufEmZPZv0qiuQMQ7
	7/w4LQTyYFNkzG2wHEpXGfobpCbFYNHI=
X-Gm-Gg: AYBFou09WgHlFMBX5anJwVhAdLh8se9eFtp+ElHfLORuKc7rBYVifsO0kfbkLs2SMsi
	x7zMheLxQgPppNvvrB2o1KmpXQa0dzWfO3vIwjuWn61f0/64jSC5Tu4pN/O7R4BYuT3hrH66d75
	/QLVb7uWCgDG0YxG3Tpr52MU+mlzbdhSMyWe/XYOkKaqNixbNK8E1beJQ4IknjXM5ANVUZCmmlh
	MBhTeRycb9d/KeqEM5GZwd5KzWcZiyL4/je8y8LXhGrVQ83h6ksyydU1qmgnAoqjShG8HLTfY9w
	F1nm+F0O/RUBM6w2yUMbf6uxuWoQW37ISmSoEVfEsdkXZ/v3VvczaisuCiBvrfC2j7XjAaihZF7
	JykQt9PUwV2SNC3AGn5XJ6pbDNmkvBugv2mcJOLlTcVz6xrb6tE1M4zEFGNgbdYUyMQ==
X-Received: by 2002:a05:6a21:ed0e:b0:3dd:85aa:4524 with SMTP id
 adf61e73a8af0-3ddf7f621c9mr671555637.31.1790114251607; Tue, 22 Sep 2026
 14:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_eQjfg_-HLT3zJ5Bt5LWbUTx_+fLG5ggLPNY1Ah+sF9GA@mail.gmail.com>
 <20260921093707.1432184-1-ljp1205831794@gmail.com>
In-Reply-To: <20260921093707.1432184-1-ljp1205831794@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 17:57:19 -0400
X-Gm-Features: AcwNN1U7cgG6CZuztU84c0xhghDR4KjaSxl8F5SVHRVMSVuORbENN7O2ZFigJc4
Message-ID: <CADvbK_ftzE++ETSSjwUL8qHAzjy6eZY6uU0oMJyfBABC1CdFKg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: discard the rest of the packet on a
 stale-cookie error
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, imv4bel@gmail.com, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:37=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
> Hi Xin,
>
> Thanks a lot for the review and the suggestion.  Implemented in v2:
> SCTP_CMD_DISCARD_PACKET queued at the end of the stale-cookie retry.
>
> Verified with the reproducer: the kprobe trace now shows the ERROR
> chunk still removing the transport (sctp_assoc_rm_peer/
> sctp_transport_free fire as before) but no further chunk of the packet
> being processed, and asoc->peer.last_data_from keeps the redirection
> done by sctp_assoc_rm_peer().  The KASAN use-after-free is gone and
> the association completes the retry handshake normally.
>
> This also takes care of the other same-packet sinks the sashiko review
> pointed out (sctp_cmd_setup_t2() and the sctp_make_*() reply chunks
> copying chunk->transport into association-lifetime state): the
> remaining chunks are now dropped before they can run, in line with
> what sctp_inq_push() does for chunks whose transport was removed
> before processing.
>
> Regarding the cookie-echo restart path the review mentioned
> (sctp_assoc_update() removing the arrival transport mid-packet, with a
> bundled [COOKIE ECHO][SHUTDOWN] reaching SCTP_CMD_SETUP_T2): discarding
> the packet does not look like an option there, as bundling DATA with
> COOKIE-ECHO is a legitimate fast path.  I can look into clearing the
> in-progress chunk's transport on removal, or a loop-level check, as a
> follow-up - please let me know if you'd rather have it handled here.
>
Thanks for checking the AI comments from the last version.

First, you need to check if it's possible to remove a transport that is
the same as chunk->transport in sctp_assoc_update(). As far as I know,
the chunk->transport should always be included in the new asoc.

> On the bitfield concern: v2 no longer reads transport->dead at all.
> The race described (sctp_icmp_frag_needed() in softirq doing a
> non-atomic read-modify-write of pmtu_pending racing dead =3D 1) would
> also defeat the existing transport->dead check in sctp_inq_push() from
> 03a9d10ecf71, so it might be worth moving that flag into its own word
> separately.
>
Sounds good to me.

But move pmtu_pending instead, as I think it's the only one bit that might
get updated without holding the sock lock.

Also, split this __u32 field to two __u16 fields without changing the size
of struct sctp_transport.

> As for the reproducer: it is a single static binary that plays both
> roles over a TUN device - the victim side is a plain SCTP client
> socket, while the peer side answers the INIT-ACK advertising a primary
> and a non-primary address plus FWD-TSN support, injects the bundled
> [ERROR(Stale Cookie)][DATA] from the non-primary address while the
> association is COOKIE-ECHOED, completes the retry handshake, and sends
> an FWD-TSN one second later to consume the dangling pointer.  It was
> verified on tlinux 6.6.119 and on mainline v7.2-rc6-343, where it
> still fires with 03a9d10ecf71f applied and is clean with this patch on
> top.
>
> Since it is a ready-to-run trigger for the bug, I'd prefer not to post
> it to the public list - would it be OK if I send it to you and Marcelo
> off-list instead?  Happy to share it in whatever way you prefer.
>
Sure, sending to the maintainers is okay to me.

Thanks.
