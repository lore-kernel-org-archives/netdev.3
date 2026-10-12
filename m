Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637436A03F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785332; cv=none; b=Sq85iYAFtS96n6kI0SX3gpfxzR5V2skmYe7acirLUxtfHSYdVnS9cQEaWBA4qF3xdVTMJTqhzfAnEPi5UJjih9+/5YknuBtfURx35aKZaeWnCryjQAU4P/eT5kqXeFKvMYm5wbYYkAx6aQcm1mZP+El5nJsiWhDeyL9l0xRjUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785332; c=relaxed/simple;
	bh=cosHv8xyr0t36btszO5L0e7U/LiWe3xxiHukHmufOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj83I4u8pWsk2vBE/4D5KgQBaLsA3jB1c81JZOmQ8XJlELe9kCfuaWGnTAH6YPMp2HN2wgeiHqAKUpTqFks8aq+KfloTIj24fmvcOCeJoQJnOZUZgfw/FLldkuFWcIwOhGc6bHIXAOUPvqk57rDYJep2z8azR49JgSdpvGIYzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtNWxvDG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgDC2FQl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtNWxvDG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgDC2FQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791785330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GRhXvDSJMGEbosLzlxSFhMKfkKZMp2xgG1/1x2ODX0=;
	b=JtNWxvDGDQbe+PFghmyjqLFLWZ1WVpAJbsGNeUQXRVnrzMZc9mkN4msr0/OsSYVQGIp8Ve
	S2VEQQKF+Hv6nGXNuXhtx70bmia1XOYN7CgO2KOGPVdG9JYsQWyOi81CmsP/RlUSpARpvo
	DjNZno+hBDk1fek77Uayk9TBxkpB5Cs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-_2hfO5h7NPiGJ1L_EW1Hqg-1; Mon, 12 Oct 2026 06:08:48 +0000
X-MC-Unique: _2hfO5h7NPiGJ1L_EW1Hqg-1
X-Mimecast-MFC-AGG-ID: _2hfO5h7NPiGJ1L_EW1Hqg_1791785328
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b02e93a1eso1086854f8f.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791785327; x=1792390127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GRhXvDSJMGEbosLzlxSFhMKfkKZMp2xgG1/1x2ODX0=;
        b=MgDC2FQlDVKxKC0qfqizTUbbnttwQC+DUHb0LH0W2FHzNgFaK292cD+2WOi5J4bmYJ
         WGVGUYXa2mE5zlB02HsaVtAf3dHAnW50/yCrIs8tyohYWVK7xEuzichpkywCGQMfV4B+
         JkVHoJO0ttIl5N2HQThpQt16A3UVOiI0iVnOxonQNLim8qQ+fviG7EFhLc7p2Uncypkj
         zfNfdESF1MoH+HbL7DRoxSbsquuUrAcM2E5PNcAzjpEIBMP0MdDDbxPL0LDLszC+nzOq
         UG3T4+AA04x6STRH1kEn8Wny7eywh3fSaWbTTysubmqRBig9d2etKIWFx8QKKuVdwftX
         ZySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791785327; x=1792390127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GRhXvDSJMGEbosLzlxSFhMKfkKZMp2xgG1/1x2ODX0=;
        b=AYIdc/3jiYTNWVjrFGas/w0irtWWC9be2yfw8D/JK8rSvQjNgD2wR3ifL2zbEKoRpC
         dLvJ8Ye1nv8xNCl8iWmpZcHyHcCR43UmOy4whRrTkP9DiWV4VYEmsLn9N3n+Cw8aWrcX
         sIJkoDnvwchxBsls1MwEATF+PutcvI8iu2E2JI0bqZy4YKGIDrmBoHy0dFu8YSoW7LHN
         0rVl6mSq3gJ0/XwBFR8uYKVB57+HvyjwHE+QFaT43iXK1IG7RNN9voCnkkpC/3sJoqI/
         nib1QqX9zdo5QtWC8Y38kkUt0yRSf03ixZB7zUqO/WLI8SN2zW2F2Bi4tLApbHGQz+sO
         R/aQ==
X-Forwarded-Encrypted: i=1; AKwUvByYWa5uzhOF5+/m3lTcR3zwtc0Z65Nmxsbna6B/ndcmnf4R3AkSfU+TT8lpRsXpQQllqnjC5t4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaVBRNiN8KFk1VGEscm3piwtOAORKdCu6BYmRjud0zrzLts7CG
	20J+nWvmyraP95Fc78xezXwYog2AspD4Hk8n3QrA0exSzTx/OzZWi8/kxpVTfvzHDET9rqUWIja
	5udnxPaRJYfdsQzxVdDysq/9bgA9UQcGQ8pv3zQt8D0HkstFglcVzkU7a5A==
X-Gm-Gg: AYBFou1r+uXuW149EviU9AK2UWsjykXocM34YjoTwJYERfXUFcpM7oK4vX8N7EkfbZ+
	mR1r5bFi9Lq8LZxnvg2ZZo/bTFE3gHq/TZyhaRnDy5D7rLo162zuA+REkx9vM06ptrjktShq9y3
	Eik8B0Fk84mMdcONPpmKxD5W2LFOc3q132eSRDXxBw69Gm2QhK3g6/EtH2uo30/9gAFD1J3/Rgk
	sRRBcUP4pDDx2fzoRATEgvHmA16/I06nXMapX3rAndWrTsqRLwRk2lfu/LGAEaC8CshBjWhAnyP
	Jnda7RzKG9MM34kKX/mwlwR6wJpham/d0BVCTMH+UR9brXB8hq8P2Ipiq2Q2okCnLc4kMA==
X-Received: by 2002:a05:6000:26c6:b0:48b:10af:f85e with SMTP id ffacd0b85a97d-48dbaaee1admr14696057f8f.33.1791785325710;
        Sun, 11 Oct 2026 23:08:45 -0700 (PDT)
X-Received: by 2002:a05:6000:26c6:b0:48b:10af:f85e with SMTP id ffacd0b85a97d-48dbaaee1admr14695991f8f.33.1791785325117;
        Sun, 11 Oct 2026 23:08:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c38f4sm19939856f8f.27.2026.10.11.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:08:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 02:08:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
Message-ID: <20261012015950-mutt-send-email-mst@kernel.org>
References: <20261011014803.100454-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011014803.100454-1-physicalmtea@gmail.com>

On Sun, Oct 11, 2026 at 09:48:03AM +0800, Jia Jia wrote:
> vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
> protection sgl and subtracts those bytes from exp_data_len.  The length
> passed to TCM is still exp_data_len + prot_bytes.
> 
> prot_bytes comes from virtio_scsi_cmd_req_pi.  With
> VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
> check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
> data_length from the CDB only when the protect field is non-zero.
> target_cmd_size_check() leaves a write's data_length unchanged when the
> CDB size is smaller, so a command that does not get that replacement
> keeps a data_length larger than the data sgl.
> 
> The KASAN report is a MODE SELECT whose header had pi_bytesout set.
> The data sgl held only the parameter list.  spc_emulate_modeselect()
> walked data_length and read the next physical page.
> 
> Pass the data sgl length.  Protected READ and WRITE still take their
> length from the CDB in sbc_check_prot().
> 
> KASAN reports:
> 
>   BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
>   Read of size 1
> 
>   spc_emulate_modeselect
>   __target_execute_cmd
>   target_execute_cmd
>   vhost_scsi_write_pending
>   transport_generic_new_cmd
>   __target_submit
>   target_queued_submit_work
>   process_one_work
>   worker_thread
>   kthread
>   ret_from_fork
>   ret_from_fork_asm
> 
> Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> v2:
>   - Drop the claim that target used to subtract prot_length.
>     9f977ef7b671 cites 14ef9200, which is not in the tree
>   - prot_bytes comes from virtio_scsi_cmd_req_pi


you can mention the other patches you sent fixing
security maybe this will calm down sashiko.

> 
>  drivers/vhost/scsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 4f8c0260bc9e..4bd29c2ceed9 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>  		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
>  		 */
>  		cmd->tvc_vq_desc = vc.head;
> +		/*
> +		 * exp_data_len is the data sgl. prot_bytes already sit in
> +		 * the protection sgl. Protected READ and WRITE replace
> +		 * data_length from the CDB in sbc_check_prot().

this is barely readable - could you improve pls? even if that makes it
a bit more verbose.




> +		 */
>  		vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
> -					    data_direction,
> -					    exp_data_len + prot_bytes);
> +					    data_direction, exp_data_len);
>  		ret = 0;
>  err:
>  		/*
> -- 
> 2.53.0

