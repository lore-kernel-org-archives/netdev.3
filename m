Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629047;
	b=czvdR6e5cbDeXegiWQP3SMpW4Xs3YdY+UwZRZYndb5cid4XYocj1EnK+fEK2N6HVDOpz
	 EjCB+cxSmhXEKdWdm8kaLd8a7bw8btTGRa8FICzzrPEj35sGYM1LusTleAMJvyGFBllak
	 GHCfBc/eK4+VjBMM5SsnKPjAu5bS0V967zbtKH0oSSbKctvY4bekQggm/PIw5lNbRJzF+
	 ThvPVqujJKYqhTifDJKaX41fNNjrUcMA1pXg+sylqo5KQiZVbDM7UFGfxcmRZRaCDIWCl
	 P2exIsvqDXFjHGFBCAhtYdyZttiBwgOWPs2L1ozqJ60+OY5UedvEss07jNHjzUzqa3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629047;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=4SDE6ECaJksWjLpMcNCkxrRkzq8jfLyJJH34fWBLlEQ=;
	b=IYcfNZ7mVzFgsiZXf/uOh4VKyc3Krph9nqNZpcRjuHWMGeuTvYXm7ebT6PT/tX1m48aU
	 jjvJUYkgguwI61cSA4ZzbjESk3sDS8IVCw/8XLsV77Tq7dGYuNbjx610yLBP6mH/yS2nj
	 7v3m/zCgDBqAEd/UDcCzsu9/BAFxnNElYjJSXSrzN8ZWhR1Dhko6KtlVBF5NPCRtFUd2F
	 V6sFUf02Xy9pB8UytDg2QgNoi/lG98TSOQ8eslLH8P6wC8XqnJte3Sbqq/xyI5zX0QHmI
	 GkVk7+2TbZ/s3T6Z+sk/tD/K8SIGrS3/FczAdusMWBQCsSsDl7lZXSZoUUgan6LjzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="XeAZ+M6/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA6606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CFA6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeAZ+M6/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793629045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SDE6ECaJksWjLpMcNCkxrRkzq8jfLyJJH34fWBLlEQ=;
	b=XeAZ+M6/HtieEVs8OkH2Z7OE64HEmmGyDlaCXoZpSyGdF3lGLo+uYwlhSJ9NpVNmoZb4I6
	IK0AE8sMe9//QXwiWcjROxu02uDYZ4dkchSXy/+5qYhKJ8uiozk7yS05311N5vNIY0IHGy
	dt/uWIBx2qW5/IUtO1dWfv0tEPpR8A0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-kGq7EujnPdGt4o1GQVYYOg-1; Mon,
 02 Nov 2026 09:17:21 -0500
X-MC-Unique: kGq7EujnPdGt4o1GQVYYOg-1
X-Mimecast-MFC-AGG-ID: kGq7EujnPdGt4o1GQVYYOg_1793629040
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22D41955DC9
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:20 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 531F6433
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:20 +0000 (UTC)
Message-ID: <094a9e87-a6ff-4be3-a9ff-014c033345e5@redhat.com>
Date: Mon, 2 Nov 2026 15:17:19 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] devlink: sb: do not dereference a missing
 shared buffer
To: netdev@vger.kernel.org
References: <20261102131505.611343-1-xiaolinkui@126.com>
 <20261102131505.611343-3-xiaolinkui@126.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261102131505.611343-3-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/2/26 14:15, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> devl_sb_unregister() looks the shared buffer up by index and only warns
> when it is not on the list. list_del() and kfree() are then called on the
> NULL result, so unregistering an index that was never registered, or
> unregistering the same index twice, turns the warning into a NULL pointer
> dereference. list is the first member of struct devlink_sb, so list_del()
> reads the next and prev pointers from address 0 before storing to them.
> 
> The register side already fails gracefully: devl_sb_register() returns
> -EEXIST when the index is taken. Make the unregister side symmetric and
> return after the warning.
> 
> Fixes: bf7974710a40 ("devlink: add shared buffer configuration")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20261030033332.3685172-3-xiaolinkui@126.com
> ---
> v2: reposted against net-next at Simon's suggestion; no code change.
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

