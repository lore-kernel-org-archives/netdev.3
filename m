Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4844DB6D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552198; cv=pass; b=lo/XA9z6RfVKtLX99xyaE04dbinZGlTPotwPGe7n+2cMU/E4bWzO4OZ/r8DQQj1+hChu2OfraZoCkcmwn+wqz3xIVoz5slvVPnqcwkCp5VXI5HnObzMpczQ5PIavezwpJ5BgE8k+al1V5U4XoDPdx0Yicw6fhia2tcsCrKk03nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552198; c=relaxed/simple;
	bh=lfiU9R11WAiIsvqMREjmE0UpqSICItkfVA3nD+UNc2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HHBmJKhHhZZwmhQGr90fnjHSGMYEfpieKogZwCftjZgcssxqiYlTU94nF50Jav947FXSgyQHRxqmnORv/rT4GVKFi7G5GvOZc4jJpyN3dBYRZ386Of7WyCWeZ1dHzNe/SAx/v9dlbmmCJCZXxJuUl9Hr5Bf9X7tvxUvDUj4cu3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK1WBP2h; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK1WBP2h"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so10514185e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552194; cv=none;
        d=google.com; s=arc-20260327;
        b=FrcTgWYuPB2jG5y+O8mfks9VnOLrPzeRJ+/R3wv4HPanvLDDd+6k4xFHXm/pZIy+nt
         9X39/K5WJpXR21+PF+2MnvZxagdpQnwyTph2ABVV3ocmVQGV6GF2tczytZdi/0oGAlFo
         1vFawZJTbsmQPo+1rYmHt4yh9oETkoQGrdIB40GMB1x6ivQ80PmKkT25JV7r2RX2HYxa
         5kQ/A/SO0KuMX/kJUYbXJ6fm4jte56ViyeAqNVp/PY2GVBSQ59gkdwhQ0PGgWv0+rJHl
         zNoyEZGj+nBYXD0v7yNAuy90arjSCwb8dtJhTv5BewkuroyAEruG1qjNx5fhNe4UV6/p
         cX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pcGip++BeeO0nV/x9j2W/Iy1AiORTN+U+AP1GLPqKck=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=pm+sUDO6Uf5x97KHFo2wDeUHT0bANG87h+mih4YE76a9m2Z9UgdqgRG96puoAYK2XJ
         HTss/OymsgoxVc99FKG3xbFx6ZbmyfyHRDGIyRo1O1oVpwNZ4ZLplqcnfxNMk84g3vhU
         3TZNEqQ5k8m3th7sGmAXx64KV7KcAweUvjACnuguxP7jayd8LAE3I6bXyszM0/BRTeFz
         vuqU0s9XtQWkbPR4hBDSe2rR/Mr/5YkfqhZh1lYwsGpQpuivpY25v+15CMWUXIZJx2C0
         PNOjetJ9KztZFH2yUNxrUw9Prz2zQAnS8Ve7g6hKk6M5cEzvgBQQCjqX7J4FvW1wixZi
         fYdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786552194; x=1787156994; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pcGip++BeeO0nV/x9j2W/Iy1AiORTN+U+AP1GLPqKck=;
        b=QK1WBP2h3Rrh4G0qe/issm0IaZ4KnwKcI24rrtSnikcU2xWYmGisQbbBlg9Mgb6QV2
         rIvC4jLPpWYyXHgR/RvHh7RI+iwInZxH1p4Lg55r8YJIJyFh/vED9j2yVvv/qVXjVN9D
         gw15DO/mjDMnVYbmHIDymlv8oBkiyy2uBLdyd2DySrFuCX7dQbY8GJsRWudqsHuY95X+
         Xm8srVNZBQNDeAcQ6XWs1s3cw8rlTEsVkWC198/0srC2ovcmXRvsgB9FINaSYuDyrwY5
         WJ738uqvfHoWHUnJ6aqw64wPGrFmboM0o4VfNoOGpGl3gMBU915ianTPf4vVHIRbEaQ2
         JPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552194; x=1787156994;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcGip++BeeO0nV/x9j2W/Iy1AiORTN+U+AP1GLPqKck=;
        b=F5Ii8/FEc/2nKs+xqUsxlDwqu5/98d4r30gO78nJuMcg4J/6q201oEj0CzGvhTJV6a
         FZBQWyAaxac1bV2qaiKKeT+eGL9oX1YtKb8SIfzywFOWJp4Fz8txrkpiJR7+wSJ5yT3r
         8DEZPrMPUhut4ugT/6NcsSLBYDne+dwa9UMvFLswpqF2fuCSPGplRgklO45AFJaAvt5e
         +xFQXYJC+tnlPhMWuqU0NkiFQNu/njKHd+jb7WlF3s+4TAPx3KwgXzQyhQ8bARcJWljX
         0twTE2tXwXZtShSrLOf2bUkyI5NgxPggLA4Vui9cpGpgSep4+XUmc1pEj5sa1pXAdRot
         qJBQ==
X-Gm-Message-State: AOJu0Yxd8HU/DIgVRlj5rxeEPX4STHHvE+86EgEBEBaVxLaXyGwUW4a8
	BERdIo2PXhILfBNeTxGtKJHVgYcbZQxcSouG5qIU77UfUYkX4NHptf6D9+9HFrj1Fn0Wrd2uqkZ
	RFdp7vjiJxSufliURcCvznGrIjXK1jPnJ46zH
X-Gm-Gg: AR+sD1148pbNSfRUVv20gxfxKy8kNQT08zMez2EKTKsSfSYr65mYRVXjoB4h0r/9QHi
	W76I1j1q1yD30wmsOzmgL5sjFUo+eP54C3LIG6Tsgf+0aJYkPw2UwNotnshdYXlneO5q8XtNj7O
	J6CPNaGqjm+eCyYTIvGLJONQTqXKdbh8vD3KTJRH5R9BZE36WW/ONQSpY77RXFMMpdvTM+y++K7
	IUlxsy8KnrPDYkZJRidfYEGwZbo3T/9bI4xAfV319mJOrKr1Ri0CRIYKE0Pm2X5dfezugdaGfT4
	qou+SUYIoU3ATbj5KC7dPXZok7cCdC28IH5wcNQTJxrQBSidqpVxs3OAS5HBJQ47YJjWI++6vSK
	EJhc=
X-Received: by 2002:a05:600c:1d23:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-4997c0f04f9mr82552125e9.3.1786552194401; Wed, 12 Aug 2026
 09:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
Date: Thu, 13 Aug 2026 00:29:42 +0800
X-Gm-Features: AUfX_mw8EzSs_nHHcMKnmSbgogA5W_GcDtfpUFShdUEZaJb7nZeRwCN_RmYoUO8
Message-ID: <CAOvhtVvk+HmPeyT94dumkmf2U-O032esD-hRmj2yp12gyUvMTw@mail.gmail.com>
Subject: [PATCH] net/ncsi: Fix Use-After-Free in ncsi_remove_channel/package
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From af39fbef05b309b7e183690dbb7e63295ff0be5a Mon Sep 17 00:00:00 2001
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
Date: Thu, 13 Aug 2026 00:25:47 +0800
Subject: [PATCH] net/ncsi: Fix Use-After-Free in NCSI channel and package
 removal

In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
ncsi_remove_package() remove objects from an RCU-protected linked list
using list_del_rcu() and immediately free them using kfree().

Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
readers traversing these lists under rcu_read_lock() (such as Netlink
dump handlers) can still hold a valid pointer to the object. When kfree()
executes, the reader is left holding a dangling pointer to freed memory,
resulting in a slab-use-after-free.

This patch fixes the issue by replacing kfree() with kfree_rcu(), which
defers the memory freeing until all pre-existing RCU readers have finished
their critical sections. To support this, a struct rcu_head has been
added to struct ncsi_channel, struct ncsi_package, and struct ncsi_dev_priv.

KASAN confirms the freed object belongs to the kmalloc-96 cache, and the
fix completely eliminates the crash.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
 net/ncsi/internal.h    | 2 ++
 net/ncsi/ncsi-manage.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..19785ca2392a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
  } monitor;
  struct list_head            node;
  struct list_head            link;
+ struct rcu_head             rcu; /* RCU cleanup */
 };

 struct ncsi_package {
@@ -253,6 +254,7 @@ struct ncsi_package {
  bool                 multi_channel; /* Enable multiple channels  */
  u32                  channel_whitelist; /* Channels to configure */
  struct ncsi_channel  *preferred_channel; /* Primary channel      */
+ struct rcu_head      rcu; /* RCU cleanup */
 };

 struct ncsi_request {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..368085627807 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
  np->channel_num--;
  spin_unlock_irqrestore(&np->lock, flags);

- kfree(nc);
+ kfree_rcu(nc, rcu);
 }

 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
  ndp->package_num--;
  spin_unlock_irqrestore(&ndp->lock, flags);

- kfree(np);
+ kfree_rcu(np, rcu);
 }

 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
-- 
2.55.0
