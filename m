Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072E35DA78
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040766; cv=none; b=AC/HVz08fiX4MhrOXvBtvKb0nNO3qWClVg2xuSLb7vbhTA7EqoVVk55JQ1tgZuPyDDSG/NmSFRk18tzenu3TrggWCkhtw6IDECklftBXqJ+m6mui7kD7lIZxRhtI9tUpKW1dNRHYK//LxvHbnSTZfyiP/K176FUwPZYS6A6prYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040766; c=relaxed/simple;
	bh=w11y49jbyV/4vIC2F4b6XFOH4Euf+45PUeCl4BzyPVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2mwzJJ6HSuhVQXtLKHvPM++AooeFvZgd4T5HttM24i13RZyLNY8O2llsJdhIxIAyHOJJ4TfjdF2Y1qB+fi7Awsc4Skwz0b6lNNIx9z5xogpSiAeNPKKcRFav5WE9OErnMM2B790oAa2Cjo3PC0rtdQcQoLtpShB3d+v6htInEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGmHK5U3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGmHK5U3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-88b5f43cb8aso449825b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040765; x=1792645565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w11y49jbyV/4vIC2F4b6XFOH4Euf+45PUeCl4BzyPVM=;
        b=pGmHK5U3snngF0QolHy6HqPWemjepwXdVLMaJA7GLUhRUx27xqrLkzKpfIAvC4rxUm
         HLfjL6qXdeaM0XGLHROVG2uZYiQ5T/m/UxIB4C1LWONqIo6cHri86tlelfO9CiJ3J3y/
         8c+Okskgh4SLYTeqnw9p8dwRTk1qlND/j44mUUTMSaLY0bsiqqIwnjZIHCyuJA+2g5Wg
         WNL9g+IYESXF0U70hAchIle17YuUKB4OZhyvWUFmL6Rib01c8hHVP7zh08T+tTBsX0gW
         hHGG8hWdvEcbB3B7bzTKerBinYtvVnxVxPCdb4dWQsyVeUcLeekOxCSBYJjfThkR4grd
         If/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040765; x=1792645565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w11y49jbyV/4vIC2F4b6XFOH4Euf+45PUeCl4BzyPVM=;
        b=SFgT0A41ZoD2ohvssQ8L23Z0r3vDGbe9q3zNBvqHScLFPlRu34Yi4tAatQf7zoG8m1
         dqvkVxEDCcUQ/bKVBV4Ow2snOs4JH949TSqHkm1ZFFGcfpT0iJVNI/n6jwbw2vdFa+nF
         cx4qb4lS8L9BH8jngdLCE0KIW58Ubh4JzIKe03Bdl2On65Fk300g433GOhazUR3NPDSF
         7kHptLQ2wu6bzSCMDIMOczz891oxFSFBb3O/CHonxfNctLSiegfL88MkAReFtJY/pKz6
         pH6JIuDyjjGKE3P3Wjd0S+jus6vzdj/Wq5Tru3a8VxymdEkoIy5KHqGKKqHE8IyzlMZT
         GlDA==
X-Forwarded-Encrypted: i=1; AKwUvBxlnJ2k3QUDgTRDBFNt2FgotVK+OhtYTR5lVc7TipS4I9weKwkBXE0cFC1fPgotXXF4bpG4ZHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx0VPb40l58lSE3E9rZ0EwCPlcfJKC+4gMMwmFz/hfpQwbJaL1
	80zgwH95L1Ud66Mi4J5SXW9wLly5uuc69jTYN/6PtxtaDmRMpLZ4mi97
X-Gm-Gg: AYBFou0o2XeHrUsarD6PDEW68X7G8TYlVhIiCYt5ZjA6SjIAB+clEh7SItKwxcpH7Fz
	C3xLmlKYIzPE9Gc31Dh0sBGX/H8VO9xIwZbbPOv3u60wJqvZ7VskXZhDQE+Eq9Q+KPwgdcFTkE5
	UFIOUR4fUuNSsylojLWNs/Io1QLnBZzJC6iGxnVn+Qkqqw0cG/7Gl4YyivVRhsMKaNHxL3Pm9fs
	Ss9oj3JDf2jZD4+kt/MyunICa6dUm7wHFci76rATuZ/7PGFhKFK5vnms+DRKmfIifL905cBSC+w
	AQ2ktK7EyIDQToyHVrQnxz6mV52IJ3EbXRq3ilRXwi3EIy8yAMg/A2XBdqBy+rEskwcCPfyNRGh
	fsQi88AIbmCL0amxc4jt7rsFwyzKEr/X8CSe60DnhZqYIyatuokohh50fh4llHJ1QerLfLKbq6g
	4kTV3he4VRsunSPz++tzAdKNbE5/fPjX+j2SfboHSBv6UC+jLgD3gfWptNfA89uB1qpzzJMq4G8
	OHG7Pa3zIY=
X-Received: by 2002:a05:6a00:8019:b0:886:84c7:72b3 with SMTP id d2e1a72fcca58-897c78d79d0mr14722485b3a.26.1792040764769;
        Wed, 14 Oct 2026 22:06:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d7f51f452sm1726602b3a.1.2026.10.14.22.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:06:03 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] ipv6: serialize address publication with device teardown
Date: Thu, 15 Oct 2026 14:05:51 +0900
Message-ID: <20261015050553.1835517-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012145306.GB779501@shredder>
References: <20261009054042.272944-1-4ncienth@gmail.com> <20261009054042.272944-2-4ncienth@gmail.com> <20261012145306.GB779501@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You are right. I overlooked both earlier comments. V4 drops the preliminary
READ_ONCE() conversions and the disable_ipv6 recheck. The new locking now
serializes only idev->dead, the state relevant to the reference leak, and
leaves the existing preliminary checks unchanged. Sorry for the churn.
