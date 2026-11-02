Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628913;
	b=jGc6mNcNFF+VH4vhvBLDBC3NYaCLGpl2A51Bp6v+leQt/ehitXSHKozFiv1/As0q0vxs
	 T0uE3/T+vm08mEWPdiWoof7ytjN1X640EyPQhcBtRMoNx8j9JngJV7boXyGfR5l0fvmQ2
	 qmjAEa8/ENe47VnEsmZNq/HhjkOMmnKKpsxL6vcO71swQrRB8Etg9FW6TFahA6qy/ZaR8
	 PwMNcl/2Fb0I9qHExxoqe1C/JI4ErE4TIDU8zdGu15WUvX8oLZ5YZnj1mf5YyN9146ELJ
	 tVCvsN5u+U0QSx1JHcDJr4fRoBAuttPLeaDSPmd7XKocKsnM7cr5wEGuLN7DbTWSU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628913;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=aK9mCRx+UfUXeMAkbOO77Du23rSI6QO0aldKSu7qjvZh0m8OGzGRaxVBtTfVjDhlv9zf
	 M8K3+KwbHbKMhMdBNx+zg6Gjbs4XIwwhjH+OgEuFhU5rKWlRFMy8CPSTDOFXQ3xFp6+/1
	 DUHrTvqar3TUuAmcY41CZguP4vm0INKhQBN8bqzDRVcjQ/vKvxmB6oqxLlH0ae5aRaqmf
	 rjdSWK5gvmMatwd8o0vwFo7Pr7eEiqhb7CVNs9Wa2x55Mc2yvctCGWgtPK2zm4wd/nreT
	 7MVW3J47+FrU8r1xKrwG18MLwz66SudP5GUbJyARY+6oSol1V10OMAJ5CDQ3xv9AtaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9dMeVlX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=doeMgxEf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775560A2605
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9775560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9dMeVlX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=doeMgxEf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793628911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=L9dMeVlXIytiUJTw094OqZstJIA8ybKvQCT0j6qdex6E5OeexAGr8A7b9vZju4+VRY9ZO9
	nOsvX+uUvx+/pJKgD50UzJhhqXxK0ZhZVUfg9AzxmtQYXvNSL1atiQk1aZxx6g4Vr1PTab
	JkUxIaPdkirri8bjNM/R8NhsuZMZi4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xlph-nl5MiuyjkcKTzXI4w-1; Mon, 02 Nov 2026 09:15:10 -0500
X-MC-Unique: xlph-nl5MiuyjkcKTzXI4w-1
X-Mimecast-MFC-AGG-ID: xlph-nl5MiuyjkcKTzXI4w_1793628909
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df5b058ddso2067721f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793628909; x=1794233709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
        b=doeMgxEfgvWCyLilo9IkAVuAqeF3usowt3Apga80inLVI9yjjcz22i7bj3r+CrAJO8
         GKh3VCAaCaoJQsGMyQUDUiZWNWz0CgErZ3fnCB3raeEpea/5qdKA5z/ANYIH/Pn7iEs9
         C5uw8XJwlc6e30a5deJIb3/iSGKyjAdEZvIdgqSpoHtAy+CFyMactuF7Y7ZhowHc1mb4
         Qb8vJHbA6rRvAVABptP5eSVzdGhDYQ2/Q8pFXLqEGr/sQQhBuTv2s5syXrkOPWXpjppF
         WNxtuEztch9JEhwEdTK8Vp+ysLwAEYSPiDhMWtPwnDVaA4WuANaJu0LYyUd673mJ82eb
         Yxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628909; x=1794233709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
        b=ar4XsSmhv+DO6og2v49AFKeRqaSFlz7+49GdPovhKNesJPlrTBYf3g4blrY7Ai/5Xy
         3mLALhJSF/MIGxTZiz1ILnupLGh/3xIC6CqhIvSiljQtHHxudqJXhX0t9tCrXRNa3ID7
         LeMZY7pT3U7PYAICCMGz6Cv6UIb2ETPydnpmo/fqddhEhLH6uHTl4LGMbqE43xNzczPC
         E7aPBcZwYgroFIngP1W5raxja8h62pHkg91qgoA2+MC4YhnhloEMqjeQ1CsNAL+BRQwa
         mrLiRIX5BDapEfgToDQiqZ/M4QnCTLhYj14VDUkz80Q43BPN0++y1XLnWppbMscNERtA
         4jMw==
X-Forwarded-Encrypted: i=1; AKwUvBxJoQi4q7ToTFqIGiTw25oaUhxD6siY5Hrt+B8vbiJ5kNmHeA8e1FOOSzZwMR8tWb97+UJ+CWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oNG9blZ/m6NsApj8HmA0Pv7M32NHycijBTS7uf54LbJ5x1k4s
	YdKrMqzj2KFJsqoMNpWEjEhyXGplRab6Y7W2jVafKV7pDpfuQAflosrSV1pQPmgv79rBWT/OQnJ
	h0JCLhO9nnstwFF/NIm0Ck5oSJJMLY3cGC9LuYg8WdP+oqPXniWjBl+1EyQ==
X-Gm-Gg: AYBFou1LQgNW6eIYh94xfe0f1DkY6NcwwQ5D7w3FTubnEOXEKMz//H6mJ+aGZ1RXryU
	9iV3RXwhndSSalx10t/S25ELcgjMNH8q66/OYojs4D357haqT5kmFThMQCNBatkflwemsKRf1ly
	SafUfQr43zhqmayX1cwqe/7kr1Ja/t9ksYw8fIDSZXpX547kob4RECTBUoFCl3iqd86uFWdha6+
	v2TFvPJn7Td+X3YJNMn513G+yvbk9qgv+HG20dnoiwOcsoYOpcuPgf8JIvJ7M6boOXOdpISFPOW
	Z/cQ9yqPo11D8aDqw8OSBlpipMf6xmrzRPjeHAVEOZuFaX4HVne7LWBZ24PgDlCht5FIuUwGTmw
	brAa52Ym311IwVL8HmQr5I8wwBMpIVyf+j1mi7Xk/dA==
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529281f8f.50.1793628908998;
        Mon, 02 Nov 2026 06:15:08 -0800 (PST)
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529177f8f.50.1793628908269;
        Mon, 02 Nov 2026 06:15:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm20775864f8f.1.2026.11.02.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:15:07 -0800 (PST)
Date: Mon, 2 Nov 2026 09:15:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Message-ID: <20261102091441-mutt-send-email-mst@kernel.org>
References: <20260904005240.502787-1-physicalmtea@gmail.com>
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
In-Reply-To: <20260904005240.502787-1-physicalmtea@gmail.com>

On Fri, Sep 04, 2026 at 08:52:40AM +0800, Jia Jia wrote:
> vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
> without checking that the descriptor chain contains an input segment.
> vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
> descriptors yields out == 1024 and in == 0, so the length check reads
> one past the end of the array.
> 
> With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
> kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:
> 
>   UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
>   index 1024 is out of range for type 'iovec [1024]'
> 
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5f/0x90
>    dump_stack+0x10/0x18
>    ubsan_epilogue+0x9/0x39
>    __ubsan_handle_out_of_bounds.cold+0x50/0x55
>    vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
>    vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
>    vhost_run_work_list+0x8e/0xd0 [vhost]
>    vhost_task_fn+0xe1/0x210
>    ret_from_fork+0x348/0x540
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Require at least one input descriptor before indexing iov[out], and
> treat a pure-output chain as a missed event like other invalid event
> buffers.
> 
> Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Applied an alternative more comprehensive patch, credited you.

> ---
>  drivers/vhost/scsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..9b5f07f52b0c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -608,9 +608,10 @@
>  		return;
>  	}
>  
> -	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> +	if (!in ||
> +	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
>  		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> -				vq->iov[out].iov_len);
> +		       in ? vq->iov[out].iov_len : 0);
>  		vs->vs_events_missed = true;
>  		return;
>  	}
> -- 
> 2.43.0

