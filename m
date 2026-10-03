Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265340801E
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021621; cv=none; b=NkyyCvcoaWJ+HMOTKkdYuVY5koIJ/RJypI2AMjaa/dR59qKlmDgmr4xIRMZHlKjRcw9MtajzFMmr/t2AnGIAJFvrDlLIZd5a6xltPqUK2eBFGFpxwpX9EmYZBt0bNJ9ZY0oc1UXz+h1WtnUiqiEVl5PH3GZfh2sotZo0cygL95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021621; c=relaxed/simple;
	bh=dEXQg2gku2Ey662t0acZpm21DF8WgKp5c2lE321bxvg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gCfKt7vwVt4wq6ijADELlXc1yR2JKIW4BTV28InIh9ylvsc1YNt7L01e5nTGRY4gKKX+JecBZO3ov1gqRsTa2wUt3gVD4eDBbECtKUPYeBiy8hzmfR+23Sv+Gh2mggYM2EpK4unXGKCRK411MRdtOK2uoxBJNtdGEMM2xoN9gbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8jx5cH/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLwmXIg2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8jx5cH/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLwmXIg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyCwzvDW8cV5BMXniYnMkLasesShHPZRA73Iy47H2QY=;
	b=O8jx5cH/VU2TSRjl80z7k1H2PugHCiWIt69i93FEgUZHmp1DULN+dcng76OMtX+1xWh6KU
	EkMXtD4enMkwyHnZSrehQXz5Ka2VAXaQtL+ZQKe4ZoNwFilhx1/pbZ+Ficrx01vNtOATg0
	eu1WWJBjjmZGTPVQnzBe2+XThSBt3VE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-gn_gMSBAMh-hK1A3sSD5Rw-1; Sat, 03 Oct 2026 06:00:17 -0400
X-MC-Unique: gn_gMSBAMh-hK1A3sSD5Rw-1
X-Mimecast-MFC-AGG-ID: gn_gMSBAMh-hK1A3sSD5Rw_1791021617
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49fff093efcso6156135e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021616; x=1791626416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TyCwzvDW8cV5BMXniYnMkLasesShHPZRA73Iy47H2QY=;
        b=TLwmXIg2KrdHMt0OBqtOD3RarQeVIUE8aXnS6SCo7/l3Wd50fszr2xdOXeWK5AzT/d
         vPwNOBMQnwXAU4DhUVne9kXKK1Gw+rUer+xgL/f/gUdFJVetGbp9w0AAA8YLo5mD9icG
         +v7BSOb99WZ1qlTdGiukPdfA56oCt/Q4yZ9YBUhmNyEUvJyzvCs/hnUMx1ps3QfbyTLt
         oYVUJ9o2IQd95sxNB72JEYmWtdkj17mVo35fKfs39dFWMEEpLASb+NRJ4TgsGKlr6WfO
         zG4kwPgZuAKWpH9DItL3MK8fryGTfQ29uIymxtflJCsMMTYutp/UVNJREDlKZVU42F3M
         EITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021616; x=1791626416;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyCwzvDW8cV5BMXniYnMkLasesShHPZRA73Iy47H2QY=;
        b=g3OSkssXBEGQQNFOZ/q+gZq18O0hMMtboYL5xGSZoOsjDQ5LhDq3j/AmdIGN0jL0xw
         iTpoHu0QrFycAZI+gIIien0BvKNYLlKREoztZsQK/koTERAiXf2AMjyhzRGGl++iBUbH
         QESWj1YyHpCpH2UL6ZSKF5JI+56EzEPoJwQIgmdWJwrFYoAD1xjPriaoHOBxiWrLzw+u
         j5ft+RUYQxC4T9+baXSZVGpW6PQcv9MTzHjnLpVOTg30eud5yQRRVwUL5ck7OLoRueQi
         6oWUPwsuSN+ABpP9WZz4DNQYHqGRjj1L3g8suAEdc+YZPxJjMx3ULdB89tK2XhPbzAl1
         wchQ==
X-Gm-Message-State: AFuF++mo2BuSTj14GMTtfEQvKeh8R+/+ay0sr6T5ZNWNHiE9NI1s/liu
	YHXIBR5QseFciTzZk1s7E/O4W/4X2zUtiNyYBdYaPnNUxvxnGyW2yg351tqSG9tV6mCK0zHfC1H
	1BESV1xwtHUDQ73WPWosnr9WewLRjapVCF7LowQh9yypDja2kK+Z9FaomEQ==
X-Gm-Gg: AYBFou1b0Lh8bBZJ5SJA612bgcB4XUhVjies+HJIq4+ebTfssEztvraFDcj1pHTGFdH
	wLgDNOefpgwuanD5IjEdrCZQ9Eymy/S9AGlOI0EvtO9zyJ5gHfLMAhti6yu7AEfKzGWxK8K945v
	a7oizvwUIkaw6VQ9hiNAAEBNMKsB707IrPjBsVU6zfatTyadQdcAG03YEcVzbWVLnezLaiMlVaf
	HyxE3tX59zXhdf2U5L22r3BSuP9pEN1zCPJl859yOz/x3J2LJk30hYB4Y+ZfMkk9rPNqOo9/eYl
	QuZajv2JAWql40fsI0v/sAmBXKj3XUdqvxwjuRoEViHK0kRnGV+qukzfDtCgAvQafnnVW1oTuLA
	ewUxa/a3DOa2aS7s6fT+CDUrjn/2qEi5I5PsR8MQ=
X-Received: by 2002:a05:600c:19c9:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a16c0cabc6mr9238845e9.28.1791021616287;
        Sat, 03 Oct 2026 03:00:16 -0700 (PDT)
X-Received: by 2002:a05:600c:19c9:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a16c0cabc6mr9238485e9.28.1791021615862;
        Sat, 03 Oct 2026 03:00:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280b2e3csm189047475e9.5.2026.10.03.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 03:00:15 -0700 (PDT)
Date: Sat, 03 Oct 2026 12:00:12 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Sang-Hoon Choi <csh0052@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>
CC: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Changyul Lee <lcy8047@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_mlxsw=3A_spectrum=5Frouter=3A?=
 =?US-ASCII?Q?_destroy_FIB_hash_table_on_bind_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
References: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
Message-ID: <699B3B54-CF7F-4761-8C03-C98DE1E885AF@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 9:47:40 PM GMT+02:00, Sang-Hoon Choi <csh0052@gmail=2Eco=
m> wrote:
>mlxsw_sp_fib_create() initializes fib->ht before binding the LPM tree=2E
>If the bind fails, the error path releases the tree and frees fib without
>destroying the initialized hash table, leaking its bucket allocation=2E
>
>Destroy fib->ht on the post-initialization failure path=2E
>
>Fixes: 2b52ce02e1d1 ("mlxsw: spectrum_router: Remove unnecessary prefix l=
engths from LPM tree")
>Reported-by: Changyul Lee <lcy8047@gmail=2Ecom>
>Assisted-by: LLM
>Signed-off-by: Sang-Hoon Choi <csh0052@gmail=2Ecom>
>---
>Compile-tested the affected object with x86_64 allmodconfig
>and W=3D1 (GCC 13=2E3=2E0)=2E Base: mainline 3b7cab693ba2bab63774bf5b988e=
8a61b2ef0f32=2E
>No hardware testing or runtime failure reproduction was performed=2E
>
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router=2Ec b/dr=
ivers/net/ethernet/mellanox/mlxsw/spectrum_router=2Ec
>index 3d6fdbab05e0=2E=2E456c60b9be17 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router=2Ec
>+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router=2Ec
>@@ -556,6 +556,7 @@ static struct mlxsw_sp_fib *mlxsw_sp_fib_create(struc=
t mlxsw_sp *mlxsw_sp,
>=20
> err_lpm_tree_bind:
> 	mlxsw_sp_lpm_tree_put(mlxsw_sp, lpm_tree);
>+	rhashtable_destroy(&fib->ht);
> err_rhashtable_init:
> 	kfree(fib);
> 	return ERR_PTR(err);
>

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

