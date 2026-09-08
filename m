Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384C3955D0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851984; cv=none; b=tXNqaX12qbx6RLvY3AxIyJ6cJuLr2Yx3khKSkqnHmCt0WkLGhkdkUSkpSBCbxYjGtPT4ooIEgdu1mInPcndbLJLy2OhPhrysyUBrXQXXDELVZcwvsoZ0nDjQ3IxSEEUSyFJhnVLxiuueDKQ/314yV+WmCBtZ4C3Fd4yyPUbhtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851984; c=relaxed/simple;
	bh=cB5vGEzXCWOej9U56bH7r2afRVTc9aUEK2BeCbcmu2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmidKLTR+tnPjZx2VUlzcmnKHXseI1ClpfUvKJmeeUmf2BbroS3AXI7Q5qQS6JD9jUb30I/Okd2fmCoLl4PqzTWDBhxT1S3xIq/7FYdfoGMUtrnlwpHXqRbRj+6tHJjeu/pWkq4Pctv8Uhve/M3qvTn25BQzwy2UjOpVSFk18wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLVu6hHZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=csL/24Y3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLVu6hHZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="csL/24Y3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788851981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJerBhWmN70q2A8Z21gwtlh6e4xQWjvU+KQeKRQlFIU=;
	b=iLVu6hHZ1dTpApwGq7Jd8Nn54FDTNOipyxY+kmaUQRDyFzqZ/CFawDXvKdO8JUdmvrosIw
	dhzpVwhYLux4k6+yLQ6wBEh0k/3ADYhRb9UsUtSxTpwOM/qq8ugH9KzHPMaf/DKWLj62VC
	/PVREwRctqjfTJbdegFVNzx5WOSrDGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-O9qZwEwpMtipP5MW6gFT_w-1; Tue, 08 Sep 2026 03:19:40 -0400
X-MC-Unique: O9qZwEwpMtipP5MW6gFT_w-1
X-Mimecast-MFC-AGG-ID: O9qZwEwpMtipP5MW6gFT_w_1788851979
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499913d1a79so28600825e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788851979; x=1789456779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJerBhWmN70q2A8Z21gwtlh6e4xQWjvU+KQeKRQlFIU=;
        b=csL/24Y3lc7to/wL5MBkz3uBVY6WlhnYbApMGwJanDkR+ekR9PHReo1opgNsLRn1px
         B+94C1WLVAZQEyC6q9j73J3lM7I4LwJBfSNETEoMcSQ5BOn6F/c8NV6r6L34hb7MohjL
         X4EXmwjUsq4BA/c66cWz/P7uMDv6S/iMLt6eh0jAoBGpdBWsbnqYYTlK2d29t45/CS84
         DXk1LEqChVWKGzQ6QjkZpUyqJjRvu4IlKkjhiyIcvdrbytSMNKZyH/nnWpkdNsK/G79z
         r4sAQXdkEhAXQU0xQcydT9ggq9b/z8dkxQzbH1D62SXtzAEGWIIVzkjwYZPC6Q2982zs
         +A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851979; x=1789456779;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJerBhWmN70q2A8Z21gwtlh6e4xQWjvU+KQeKRQlFIU=;
        b=JlM5aA+eniOKE2VUWTILL2CwuBNU7Dq6R4aJdtEeY3JHeFBNYdD2Z9PTTBhb3rZI87
         mDcFcK9Zr/0qNSeSf+FNBXHGntsX5NozX/i5046IO80Zgb574VuYMjZZeNtKsbWkdMMc
         yXYstuoJRAloseK2QCsVtUXBGrzCJvVcmaE73qVYFfhwbnwpT2Hr5n3qtWPaEG81HPE1
         mS96pUwcprIK2GjcN9Pp2yxhWN/kSe9N1JRYzHYOn25vx1XUj/wT6fVGnKnJRZgAzF4M
         DfWq84vhBfNdhpnyVTKT3WV/TXJUCLLE6vtARxEbvVasNwb1i8wJzRpijCQE3oalfjYS
         5vTw==
X-Gm-Message-State: AFuF++mZUiHj4rEk1EHZwFqKU/kdv75musJ32SjzygnJ9UEbN13FyDYN
	u/lOtk8qK1z7K9I2W8C2rY4/fGyA9Xf9DIAjqoyobaL6sZFsvZpDd2EBW/e7ra8+fiuv67sbBnw
	Cebm/MbUs1MEpLKt8ApZBo/OfLf2C9bOeoJ2c4FLVx0aOMbhUEF6SXiGyzzeAcF3scg==
X-Gm-Gg: AYBFou3ZDOf3qvlSKalMb0IOXKsTi8KT1+kntLVFDVkeAZgXBQDgvhHYLRvAaMZuOm6
	7R+1vpYcxgMTnT/zQOid+x+264F58WrsvRTQvaMMm4fT9tB/kFxoPRU/OycUaDR8g4j7RdJ28MS
	iS9pSsmHOLZ7GpfftX83XNuuT5ppZsT6/pJioO2K3pWaR+5jKFyfX4RenPC2eU2Cm1wz03V085Z
	1+24UG3maeVBmnKthks8RoYgzvrfVXRlt8BLB+WqhuPyE4lrrhErAgwXvGnQkdmPge2bVgCgcso
	1C0omTSnN4ZyjzVNm2GBBDfNKNiapHY8x3a/34/vhqsd2TQ9zYB53tH6TJODSA0eYMH2Asu1uJR
	uVdqoMFJqVUv35/HECbY4WEEGyVE5HYclQzquZgsPv1x1N3fAEnaL
X-Received: by 2002:a05:600c:1c29:b0:49d:5ff:f408 with SMTP id 5b1f17b1804b1-49d05fff5bbmr284794535e9.15.1788851979072;
        Tue, 08 Sep 2026 00:19:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49d:5ff:f408 with SMTP id 5b1f17b1804b1-49d05fff5bbmr284793925e9.15.1788851978584;
        Tue, 08 Sep 2026 00:19:38 -0700 (PDT)
Received: from [100.90.169.165] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm269094115e9.8.2026.09.08.00.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:19:37 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: fix use-after-free of the flow
 table mask array
Date: Tue, 08 Sep 2026 09:19:36 +0200
X-Mailer: MailMate (3.0r7030)
Message-ID: <FD8A4D46-E107-455C-8F3F-0F52D3CBAA74@redhat.com>
In-Reply-To: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
References: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 6 Sep 2026, at 10:21, Norbert Szetei wrote:

> tbl_mask_array_realloc() retires the old mask_array before it stops bei=
ng
> reachable:
>
> 	old =3D ovsl_dereference(tbl->mask_array);
> 	if (old) {
> 		...
> 		call_rcu(&old->rcu, mask_array_rcu_cb);
> 	}
>
> 	rcu_assign_pointer(tbl->mask_array, new);
>
> call_rcu() only waits for read-side critical sections already in flight=
=2E
> tbl->mask_array still points at old between the call_rcu() and the
> rcu_assign_pointer(), so a reader entering ovs_flow_tbl_lookup_stats() =
in
> that window picks up old in a fresh critical section that the pending
> grace period does not cover.
>
> tbl_mask_array_realloc() runs in process context under ovs_mutex, so th=
e
> window is preemptible and can outlast the grace period. Then
> mask_array_rcu_cb() frees old before the swap runs:
>
>   BUG: KASAN: slab-use-after-free in flow_lookup.constprop.0+0x2bf/0x2f=
0
>   Read of size 8 at addr ffff888020b3e018 by task poc/741
>    flow_lookup.constprop.0+0x2bf/0x2f0
>    ovs_flow_tbl_lookup_stats+0x4a3/0x5c0
>    ovs_dp_process_packet+0x19c/0x710
>    ovs_vport_receive+0x243/0x390
>    internal_dev_xmit+0x81/0x170
>   Freed by task 728:
>    kfree+0x16a/0x4e0
>    rcu_core+0x853/0x1030
>
> Publish the new array before retiring the old one. The kfree_rcu() that=

> call_rcu() replaced ran after the swap.
>
> Fixes: eac87c413bf9 ("net: openvswitch: reorder masks array based on us=
age")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---

Changes look good to me. Although not really necessary, I did run all the=
 kernel userspace tests, and they pass.

Acked-by: Eelco Chaudron echaudro@redhat.com

