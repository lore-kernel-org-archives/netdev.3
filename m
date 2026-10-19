Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441706;
	b=Ped76nh/gBlqc2Dca//6G/9+sjcb9XC61+EKPz9UeQjkwWi7D+nyAYNFbS45bYe9FM/Z
	 MiF6q7Cc/ezzLafGIHAVOk1w5cOBhbMzb3fcS9fnzpMIQthIl9LuYFJjWme7qJNLoH8Kz
	 kRjpwdmjs1xabKZkXBkx1shZUcTKrRrL2DX3/nN5tVbvYAehQYw70ztyVfmRCKcIO6UeL
	 nnB/bVQVxA7z/7NWilHsWZGRyQSKBxLsylAJ+u3/MhJ3fAlg3nAag5fcg0a6w7X1sFSHv
	 ygwQ+zpcUGApZFdHXzZtM/wkL/TqvAi5mTfTr6UkHnseqnt6xnZgX04iJFX3tvUhOlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441706;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SwI4M7PzemP7Lrt2HFu5ElwpuokYBHAx6W3g1VLHeqI=;
	b=fWtiyBnO+AaMgil4Qc9CKDEI4gUU730uBwpuMAh8Qs3o9dETGPRiDCf4VF7Kw14/ZWfU
	 WfA/NfqSj3OmkOwplYlDpb0No12NIY3ppQhBKKMRs4W0Nkd+/da+dezuqWQlUa1XugBwo
	 orokvKCs0So9C7ZZFWDtYp5Kfg+pY+mgoREfLFURxq3euw9IL+sC/SffN0mnP2TfFp7BN
	 IQHLsDj15idwV4b0U+PMpbeJ4ZW+UdulN4WQqKmFMSAnnakZoqvJNELzeDBRfsGDw2h8X
	 Su3geBpmjDJ5Eod7o1o8WCUg3LAhXa5Queauyo/AQKLrhTEplvCbeDiol2x+UDLcQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgDMf9rC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DE606A31C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgDMf9rC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73791F000C4;
	Mon, 19 Oct 2026 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441705;
	bh=SwI4M7PzemP7Lrt2HFu5ElwpuokYBHAx6W3g1VLHeqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LgDMf9rCuuNoZKSAL//mS5IVPqaFZ9rlMmLRvzGN+9dtgfvC3qxHzYLASl8ChPi2b
	 pa7bOElycaCCYGJawGYAjoUvLQ2LhNj7RS12fdSYcY5sjzQWWf385nwzs9k+IDCehA
	 HSahndbqS+dFYobH4Msu8brU390qwYALaNs9NvX+ICCB1bj7QkDd6qcDjdxOtQ59cG
	 PxhV05Q+mVVZPKaq0ekj3TLT+d2UT09DCuO0yCOUC/RgpLCn9vWpi5LMMwjJI2YQYp
	 mSSSuhW1Td52x0ktpooQhTWihVM21vH32JklNDrsSPgX8QEp9ChkXossVesapguZZ3
	 pHjFV/S4OkwCQ==
Date: Mon, 19 Oct 2026 13:28:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <20261019132824.0f2b3350@kernel.org>
In-Reply-To: <atYJLGHqCelhzSee@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
	<20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
	<20261016180714.05fc93c5@kernel.org>
	<atYJLGHqCelhzSee@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 08:12:28 -0400 Rodrigo Vivi wrote:
> On Fri, Oct 16, 2026 at 06:07:14PM -0700, Jakub Kicinski wrote:
> > On Fri,  9 Oct 2026 10:31:51 -0700 Zack McKevitt wrote:  
> > > +        type: u64  
> > 
> > prefer uint and then no pad  
> 
> same here, u64 aligns with hardware definition why uint should be desired?
> I noticed the review prompts, I fail to agree because we need predictability
> and align with hardware definitions.

Just because u64 is defined to be aligned and require the padding.
uint is a "modern u64"
