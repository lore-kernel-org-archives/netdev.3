Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C626582BB1
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887063; cv=none; b=ufHpEpOj7UIR43fJ/6nvcpoS2MPlJspXDLorIIulsFFcMRCR9B0FOMIIzUqE3QBtlB2xf9oBjcZwXq0Ly1Za18CB73wksqR+sVeQv6n+m1rLMnKsxVCej/HnE8XbmNpO6O8rmrS/6gpLZYdYtp437Jn5T4q75OO4pT9YEZDQTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887063; c=relaxed/simple;
	bh=eL5BzlSm68HwvXBbEKQDBjRCnLF8bcFOZ1bx8ziLs1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdluKnbJws9+J9PiXYguTWchKaBl6KdWf1+Aa3CoOmUk/utVeVWIq6VmIik5BMCs4+e3OBnNnhv3sM/uHEpcoJv2b0FovhTmsnw382l7NCyEYi6FT39h5D49eMJDd7c0T1+xYIyLb4Z9NANW7f/fi7I+CxCb2+RlzVAeFmmwWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLSN/48s; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLSN/48s"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so30684851cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788887061; x=1789491861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eL5BzlSm68HwvXBbEKQDBjRCnLF8bcFOZ1bx8ziLs1g=;
        b=GLSN/48sJa74NbmhSIGPVfMVRtCzr+vwI4HAEZWCTyLUtV/Z0enPgx7bSn6yjN5Qj9
         5fYCGz5/lnyOAtAYr/Reutip2fh7GglsaMyYKncDTIey046mr+mWPz5EEt4PrQ99W3le
         hKGYqwRBN9CJGMNqrVPWI/jM9KSx3Zq9A2TlOvAb+sV3zqTYA7WgOoEx57fUSiVzruUj
         x4HVHVb64bVcCWO4Gy1pKbYs95lu7jzl8cMs+sdlFy0/Q4s7p70lhPXIX7GtA/wjHOUl
         prOmli3SCeZ6NICXart7rVkeBfDX+biYR7uoYdsZfA/WCTjKMw2MVlNqymfGHkjwSJl1
         Vk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887061; x=1789491861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eL5BzlSm68HwvXBbEKQDBjRCnLF8bcFOZ1bx8ziLs1g=;
        b=shARppvZbYPMbGsFgQsLY237OTivGUp5Z88Ydn8MTiHBEw5UJlfd2xGe/kRsIcIGsj
         Ivh0Q9YMHfZT7L+sh9YY95T75rEZbdfdEkGJgvfWxG82bSRUAr37IVJm3gOWbRzqoa09
         dbtmW3Z9aGs2YtkBSnBlt1GpclY9YoafaHkbr+ULYEJ3csSILBocUL5yj7/5nA/et7ln
         t1rWnoEnObFznWrV/fvHhiziztSzMRcqnXFnEDMuJ8bXKwtOknixaxhr/skCidcP/Ybf
         mzvdkSxeQ8KVutH74sMYtoQVgypRWPQWuedB8o2YtETLdHWCLTJ4XiaqVyBR+1vrNXiU
         6ldg==
X-Gm-Message-State: AFuF++k+ZuqWWSdXH4vj2ilViV3lhrIQZoSrnaDp5Mx7c9EKuX2rJahe
	uqR6h7y+yUDIhEQ7fK1tC7UopZ9AzHjKclki3WurLFioHXUpdZUwvgu9g+7WGA==
X-Gm-Gg: AYBFou1qxO2it9z2FK+P7ihEMNyxMJXy1g4QyABeMO+JwRK4TwuIMGKgW3LU0gyzz62
	YAzH94uYImNjoXe0Tc+kP0Xxvhc4VJPBlaCxwnLfOV0KLPi2BPhR0bJ7ulK1ATBf9gNWzaKV03+
	JtAWuawE8rLU59YBLRiWaHliKfyAggzwEbHPJSPT0ZjoKDsa8XK/4nNS3mirmiL78pQ6YEjG8Xb
	f96CnaNio83eWrRtvMhDdGb1ajeIPEviXc5QuLPPlT6dszV14Exc18LcTCUfv1AVhBhsphCzEWj
	ZeFtXNfk2VpUxdBw2SVB3+cZmnvf4HvjHJZZGL1P154XJPHTseSEpr30XeAzvgo3HGRCJfo5Fqf
	LcfCrPd95dESoJE9bby2hGmEJccKSfDioDv2lD8uKG5Y7oaQp/s+j6qADRl3X5iSsmTI9dg25r5
	wkxBP7L4nFgIgyCf8xh0TQ2HDsw0/lG341yVduqwggAV6kQpdOt1+HBJtJ
X-Received: by 2002:a05:622a:1115:b0:530:430f:b922 with SMTP id d75a77b69052e-53054a32ce5mr341661691cf.49.1788887060532;
        Tue, 08 Sep 2026 10:04:20 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530a2fdcf8esm3276901cf.8.2026.09.08.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:04:19 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [net-next,0/4] selftests: openvswitch: pylint cleanup of ovs-dpctl.py
Date: Tue,  8 Sep 2026 13:04:10 -0400
Message-ID: <20260908170410.1952842-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905104026.3776396-1-houminxi@gmail.com>
References: <20260905104026.3776396-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A v3 of this series is coming. On a fresh review pass I found that
patch 3/4 had its docstrings shifted by one method (they described
the wrong operations) and that two renames that were meant to be
dropped from the original series had leaked back into patches 2/4
and 3/4. v3 rewrites the docstring patch, drops the renames, and
puts the stray hunks back into the patches they belong to.

The pw-ci contest failure was a rebase artifact; v3 is based on
current net-next.

Thanks,
Minxi
