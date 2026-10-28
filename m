Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222986;
	b=DEtIt9R5QxVwrBXZem424lWxCfuGU5TXFJrFSxfys0oow8V1zWAHJnXefjJqAFNMBPAF
	 EGzw8ez7Yj/+hHw3+naeMBM1xXst//VSThCJePrXPI3S06uIBB/zjMLinDiaQ6wyxBZrQ
	 0kgI7OxTeyNl0Gk44iCP7ngQGpYYtEhA0QTRIjJ2FHLsDqybZ5lDyzl9pb2J0HPj7KP5j
	 Da96GnyouFHezJu+5OMaQT62HLrdSfdn1yyOv+VG6dUdtkgEXKdq5UqVsNoWTcRDIq9bC
	 DTAT1olYaCcPGAFpmqDYJXEPDogATNmrYqYfnwhKD7c0Zth+0Bb1ufnNb8sSatjaeDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222986;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ASKLLKFwu2pGOgKZA+t+mijx3nltyW6H3vc5AHkEheA=;
	b=meCAXlQPQRiDEuAx+BAUytdd9E+QVGSpjTLBeR8EgpJJgnhVRLMwmsK+sfz4sPxgZMxk
	 IG4Iy0a28+sPO17k8i5fWYVHqCEBicWRj6IicIIWRcl+8d/SMQSJq1fG0uUhkPnyAAIZz
	 t66dpbIT46J+AiLgm8MIvIhExHAl1CmGBFmwEAtzJbDAWEWzSVd8+M1/J+B+auWPb4lNs
	 uxVPKWVUjzM61t8Fl504xP5Z2Po1nqJKYEIVBsdv+bQnGzmFsn6oPXl6gGCzH7MJ1Ou3a
	 bBOWwSTER5kWnp/VypTfnRMaVyYLn65tNTYsgKR2OlQJb49t8udLLc+0OJjNDC8aOoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2FzBUug;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E8xc7SD5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02585606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02585606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2FzBUug;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E8xc7SD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793222984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASKLLKFwu2pGOgKZA+t+mijx3nltyW6H3vc5AHkEheA=;
	b=a2FzBUugBCB16IxMPpBkwIiP1OKCNmbJ4hehK8TSqb6heWptrIKC2vJslZzzS81FSoKVMV
	cEHbSqt+AlUm1lSwMbbDi7vKclcEZgVW2nnCjpb7WtiIEL/kim1H+aH8rhH2lZpLk8+kYE
	rHy6FvfJVxtPLScjY3qDtYeNRTDWePM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-D4Q_QRa0OFSgXYiQ2mmKew-1; Wed, 28 Oct 2026 17:29:37 -0400
X-MC-Unique: D4Q_QRa0OFSgXYiQ2mmKew-1
X-Mimecast-MFC-AGG-ID: D4Q_QRa0OFSgXYiQ2mmKew_1793222976
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4046a3bso1206035f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793222976; x=1793827776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASKLLKFwu2pGOgKZA+t+mijx3nltyW6H3vc5AHkEheA=;
        b=E8xc7SD5zFdbKp6a8Pv4boR5xd6Y6JBYrgFI0JpQeFShiukmiGn5nBTdWYeYABeGi+
         /RnF/mSHD79zgYbdeTKfSqzgbFI4RznUXfGbat0e7G7B+F5iE8r3fyjIkYFD/Rf/tFpS
         KlGfyH2RKlu1r1cBQ2TIPy2wheuUJrUD8gJqw0TW4dM+9RETDo/2gADGQNFllLv91Nvn
         AgmyrtlfLEq3nvRm0xApiSVL/5dwoskh5OqAUFEICyvflFS+PAFF2bpKarSczlE6skCl
         DeIaNo/tYxuc9rGAC90c3s6SDLqheoYy7LLvCf1KMnj0DWyqGVKYQYZC0HVbtje4LtAf
         qKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222976; x=1793827776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASKLLKFwu2pGOgKZA+t+mijx3nltyW6H3vc5AHkEheA=;
        b=y2OoaWW8cRv2MvxRw/Q3oocwuR7ntxHjDddc5Cwq7OHyRQqiVRAV5b/ST5QeI6PHlM
         S1/i/zne6NyjMAumvoV+kIgRg913dbekv8IGlblDfjaIsr3vU8fR6FMK/z+iNXwVePxh
         qzX4ozoNUcHJXuogQ9Zqs+fjTBKQxSPna5QCd4jIowEQHxhkNP8MsC+nZKFEiIIY9yy/
         A9qDIW8VUuVN4q1KEPtsTj2Ue4+r1dFuwT9izM44sPl9wVarkT36RlaAZogcZeS962SW
         8VW/5NpfWkUeTDCivNJbOYCvUJi5N44KSRTzvbgePEPQAs5p9FKhTRaZN4MoyVOkpJnX
         JY/w==
X-Forwarded-Encrypted: i=1; AKwUvBzbTRAMsvJgsdYS3vDgLcCyacw7DtygTJ1V5rBMhuuTd3CqGeDbhXZrI4jQeh74xxxb+VOeEPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdEAFBhFXdpMqq66h+dq4dNYPNB+BUqZ8u/WWZ+v9fLu1nHx89
	i4hd4PJms9XLe4fWkwcIs3MwvYyL2D+IE8Imx32h0qMpmmZlnXgh1qeqmWNzDgzEWLCU2ijwdg4
	T3Cr6fh7oodJMeugiIv72o7ePbAzQ4MvCxKtteMtFPDp3e986+mxXGvR5vQ==
X-Gm-Gg: AYBFou3vmRAJ8urKzHis1YSApmSr6WVLm66ZiIYonAZ4DGxVjdlzg4eioP/oUK78QkF
	TY5eYuDBGBgkUaY6PTqyIjSaOnURtN/qMleVxoCon4ODRd7c83m8f8SvCEMtJK3NbVmPBiSPgql
	krgyGBDOSxsutR95t3Ak08KlYxnHggy55dQtOakZkulxWPxgtrWmq0HbBSKbpu2dUrb6pd4B5dN
	asMLVvjIScfsiAc6xnoqBZe0CYKInUF105NcANZV4Muj4CV7rGgIhxtTzWthjwVmHTluuDD4SC6
	UpFp/lIbHVclJEjTkn6oXGdv2P9KwdKTlJAnqbWWgQ2qymZJKJVtQHOoIFVNXqvN5hG25fjj6Sk
	hT0AkRXk56X+8/E2x3kliQmMRYmC6lBRPJfQGRRVkLsJOfoeV4v4EjIAI5UKBF1pJxulqvm5aqP
	6+qNXeb7820P9zwzfygtIvq7pu
X-Received: by 2002:a05:6000:260b:b0:48d:e696:8a65 with SMTP id ffacd0b85a97d-48e5d30e253mr8827390f8f.46.1793222976248;
        Wed, 28 Oct 2026 14:29:36 -0700 (PDT)
X-Received: by 2002:a05:6000:260b:b0:48d:e696:8a65 with SMTP id ffacd0b85a97d-48e5d30e253mr8827363f8f.46.1793222975881;
        Wed, 28 Oct 2026 14:29:35 -0700 (PDT)
Received: from debian (2a01cb05923c9a00005ce1bcb3793264.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:5c:e1bc:b379:3264])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm30412532f8f.34.2026.10.28.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:29:34 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:29:31 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: Tom.D.Williams@morganstanley.com, davem@davemloft.net,
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
	kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
	pabeni@redhat.com, ycheng@google.com
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
Message-ID: <auJpO3m_rmyToV0w@debian>
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <20261023161013.3079347-1-ncardwell.sw@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023161013.3079347-1-ncardwell.sw@gmail.com>

On Fri, Oct 23, 2026 at 09:10:13AM -0700, Neal Cardwell wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> I asked two different frontier LLMs to take a look at this thread, and they
> both pointed out an intertwined issue we haven't noted yet, which is that when
> an ACK advances tp->snd_una by less than 1 whole segment of the head skb in the
> retransmit queue, tcp_clean_rtx_queue() breaks out early without setting
> FLAG_ACKED. Previously, such a pure ACK relied on FLAG_WIN_UPDATE being set in
> order to have FLAG_NOT_DUP set and avoid being treated as dubious by
> tcp_ack_is_dubious() in TCP_CA_Open, and thus avoid calling
> tcp_fastretrans_alert(). If we fix the FLAG_WIN_UPDATE code in this way, then
> FLAG_WIN_UPDATE does not get set on sub-MSS ACKs, and such cases will make
> tcp_ack_is_dubious() true and we'll call tcp_fastretrans_alert().  AFAICT
> nothing serious should happen, since FLAG_SND_UNA_ADVANCED should be true and
> so num_dupack should be 0 and nothing should happen to the connection state,
> and nothing spurious should be sent. But it's performance overhead, and a
> confusing dynamic that might lead to bugs down the road.
> 
> Below is a proposed patch, cooked by a frontier LLM and lightly edited by me,
> that should factor in all these considerations. This is compiled but not yet
> tested. I will kick off some tests for it.
> 
Thanks, I've integrated this in v2.

