Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76332489865
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983084; cv=pass; b=esatmuv44/hA9S+B76vHI8nHkixyCEkO5XuYtmBeKixs1NXJShbj+z2AdO0vIk+LryGhzvpQ+jxteayj6PQ6cdDI/n0M2GFf3cc+8zmZUg8QEG6qpEitC9abfmdgFs8grrwmjHfbfbP1B4dElqTfjGugTx2OYAaHtVgdY1C5m6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983084; c=relaxed/simple;
	bh=M3CCpcGVyzu9n7F17theBVYF7utuETAmiyopj//CV40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meqvNCjShIGoFSHqLIOD0e5tSuLJ9uOeY2EvcKTl9nBohd1S+rO4VakHiG6/Z+/W0h3sQrSymuE+1OO/eIcr26EFZAR8D0k9MFtQWuCw49JwJNbJk7euJY6v4rUc+Srhq+WBpTcX+MTItdr9XNUii98jRtY9F3nRhO/cnJCUwX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShFR7Q0s; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShFR7Q0s"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso25814566d6.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789983081; cv=none;
        d=google.com; s=arc-20260327;
        b=Gp4g2YzD6KUS5Qf9TiuwmfegsIIjUwHEPuqkYkl+tNzApdJx5rM0/6rTP5GgoHAWLW
         qC7cetPBlGR4mprnEWR2xXEch1JPetdVCVZu6yMpQEWPk2K3XleEzuM80+YDu7ccXL5H
         tKkIQOI2FqU7fr7tuIQ+VHT3zsxknfTg4LViN9jsXm7ZKZvCluJDVhNgiKvJt9bJxPO6
         E1wNdGmCc0im3XqCmHcSxWQ1Gr0I9I51DnREDDkGBDEqDGV2JEZ4A8hZdYk4vswDn3F2
         v30DqwOKxCP579aj5PPXqIiznJXG4FM9ORqlLWYNiV4lD9c4cnn0Fi7P2jMuEUtiuktT
         BUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3CCpcGVyzu9n7F17theBVYF7utuETAmiyopj//CV40=;
        fh=fDGYQOFYjrvTa3un1iCHx7i+V88gMiqSpCzVtcN2aq0=;
        b=BRd13PPUyeRvozpQ0fWn0cWxbe85KFEEqdYV0mZmfAbDGpTklEurHB7FzEMVgI5NDu
         Ugy37f+VCi5HobVwP6FbWazIKpLSQUkTqNybr3qbhOhd5bJ11GSPkeL7T0YN3jthFud0
         YIiXtDLNhhcdX2ORXJPoKYWUF6BCUWrGnEYPGBciCXQKpNlOG3OfzAWtXJHgPn9feQns
         iCI9jwBSiLUNE8sF0FzX/q4Uh0NmN5xIZCO/LY+RYWtbrZXxrpSmnBe5I1qAn9ZOZhD2
         oKTUz4qqbiF1oNZ7FzxDSI3RExWz6Rp+MHi5Ir07IKNVkrWFiS4ScJmGyiWD527diNKD
         JUqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789983081; x=1790587881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3CCpcGVyzu9n7F17theBVYF7utuETAmiyopj//CV40=;
        b=ShFR7Q0s/CecoIJ2UGyH7FE/WCsw1v1FFNzFfShM90znjuXBOFlIyblw9LQHnQnAjT
         3JxVTnv2cvDJXPZA9hRUiS34wHnL359NWL8eNEPSXyVjyl52MkrhXgHRsNdEpq+feDR/
         OVv5Sg1ktwrwz3tu+FJFJsrAJxy2/VtAYiW8zUBuY0rq7fwBlKya5DWZaiC3eyChkMd0
         udq9n2zvgzOwuEfeED/5iA7BiNWIl5301TGKcNVOrwkci2v4dAMseNMnICRp85z4f7tc
         11yP9XYGlTvEFGhJzBanQ7PPnwiDAOsuiKPwFHlfZS3kWQgHcI6U8X2vcQPCsJxZbngC
         1ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983081; x=1790587881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3CCpcGVyzu9n7F17theBVYF7utuETAmiyopj//CV40=;
        b=nyOx/qCDWuP5r/9HtDYo6OM2Zc+yHakfN2rJQymNne5LpFvYtmFFjl3a5ylUDxraYs
         pp4dg/seqja/IA3lmpa6y4CSWc6E0s93DzYZnpErl0SgehP8LRcK5iBzR2HwJDf+2LLI
         2ZL2tbiFUOtmr4pXuNuYmVk8/Udz7s+3ltRRC+uSIxUIgMAE4D0CEM4q//JmBVOMKbOv
         7pDd01DrblQIsa7clcAUyQMnBZYUTVGI9QBLyPaGT3IKfb/K6sNrF9EOA5rb9O7AT5/6
         l34Ze1OPWPTiJjkqFWUmzeccUpO5fGsRv/UZUBT2aTS5kDccxBYAaT/AT7yOcxtguvFg
         seyw==
X-Forwarded-Encrypted: i=1; AKwUvByKLehxYYCps/jffGsXjgW+SU0GGM2VfxW9XfWujhNuEcQ4OYDr3swBSdLPIYDAXGA4l359GFU=@vger.kernel.org
X-Gm-Message-State: AFuF++nIy5p/4n6wKth/akXPwBb8DYc87oKNMea8OqC+q5qDWpRjD7xL
	b3sRXOjcOApJbxHtDU/iqWvCxcVYyYRaqLy/VXFG4eLDD63wDsxnJMs2lHyx2V0DG52xC/m6TkF
	hxsKKA4pQvVA87podb/pex0xZ4hA1p+gV4XR01BpD8u6d/Lm7kbBRrgpW
X-Gm-Gg: AYBFou19N+am5q3htG2CwMFutgxxWWUO5qn/X67x6yqjQbAUmy9TuGQ1aqBEo/9Y7CH
	jSZv/nMwWvR6/g6ZD4ybdlL/L2a60c3bkEmA7g+V+/yZ1fKxxVP5xMgj2pcBGzro0P3l52Tjn/g
	Bg6vd5/cfK1JAHVVKUhOl+460R4ULZTFOSWzWAV7b83kC1XKBas9cXFzcNNm7D7r7jv7cpPqVx8
	+lt6MNc7yE+jRAxPxmdwMyH7jRewdmtaB/eWhhey9+7uvjANPnG9x3N3cglTW/SPQaAAZ0hBXUl
	4OsaM0i6JenLd341l8em0ED2qkNnyRY4cSn5pKrQojhWhWrs7gBx8VQaiF8jS/1fW58pVE/tDH+
	4r6M64gL9OXvMIQy+RMxrB+wDuk/1ZwRHQ1M3Qa837O7wttlzvbTy2OcdQPQ/NfcO5tA71A==
X-Received: by 2002:a05:622a:410d:b0:530:e8e6:bb67 with SMTP id
 d75a77b69052e-532b73ab76emr92521371cf.59.1789983080521; Mon, 21 Sep 2026
 02:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920191558.2990636-1-kuniyu@google.com> <20260921092600.GA2103061@shredder>
In-Reply-To: <20260921092600.GA2103061@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 11:31:09 +0200
X-Gm-Features: AcwNN1W0TZOvfQUH7W8k5FtYhlW0IgTKNUodsEXWXdqHGdstcc01TlvFY5GHGMI
Message-ID: <CANn89iKSvV4wqxeHsm9B-fjK7-WeMTV_V9UyPngm_1V_Mzgngw@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipv6: Fix dst leak for uncached routes.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Hangbin Liu <liuhangbin@kylinos.cn>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:26=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Sun, Sep 20, 2026 at 07:14:32PM +0000, Kuniyuki Iwashima wrote:
> > ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> > detect an uncached route by list_empty(&rt->dst.rt_uncached),
> > which replaced the static DST_NOCACHE flag check in commit
> > a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> >
> > When a device is unregistered, rt6_uncached_list_flush_dev()
> > unlinks uncached routes tied to the device from rt6_uncached_list.
> >
> > Previously, they were moved to another list with list_move()
> > (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> > ("inet: remove (struct uncached_list)->quarantine"), the routes
> > are just unlinked with list_del_init().
> >
> > If list_del_init() runs concurrently, list_empty() evaluates to
> > true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> > and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> > dev tied via rt->from as well.
> >
> > The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> > fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> >
> > Let's check rt6->dst.rt_uncached_list instead.
> >
> > Note that IPv4 does not have the same issue.
> >
> > Fixes: 98aa546af5e4 ("inet: remove (struct uncached_list)->quarantine")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
