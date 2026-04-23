Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE331328B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954499; cv=none; b=nM4OA97T8SLfnj5pDq6CReV70Vml8FePeFjJjX8UDDMT6soGICFwAqZsIJl600+HZBhvaiYKOOTP18AhvCBaKJnbKkvspnxSCK2DFujoKX8+9uqezMlGnUSPUd1hN4uvaOOTCH3O4/M+jRaqhobYrog+dEs9m1TtqPGWA6fpC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954499; c=relaxed/simple;
	bh=o/JppV+Dx983eMiBEjmrcNq8lBeAHnc58cRCxMJOqH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyID1h2uiQBYx23VOeY2DXQjqKkAv30gAzRPEOf846rhZbiA7MmNlazZsZGe6kMPlI+tDkVygvqY5vgE9YAC5A4ivdISHb+H1YY8N41fm9LD8mMsYCbxpo9AJCYjjHHjJgH8wVCJoQs+5grI6X4jWmOjohuNGst2EFixbHztit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQuZthBk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQuZthBk"
Message-ID: <9992caa6-ec37-4727-ae5d-80d0b5b596c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776954494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsILgP+g8nGPwhnr0VxtS2yweytWEGdJMl5bI9xgZ8s=;
	b=TQuZthBkb+VZ9iwBQ2QgHgzpb6UvLIV+GJXQ9UwWl7z+oR6fQjcKFeSbAZY50sYgX7aYnS
	+81bEAA87WLumWDzfUdKOTjCWHllbvTKK97Ks5HWvKdi8i5N20Sr96qoVhcGwh8U8pm3BE
	NzS/bjxhkxgBD55Flgo/D5LQRtgpo74=
Date: Thu, 23 Apr 2026 22:27:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] KASAN: slab-use-after-free Write in sk_skb_reason_drop
To: Eulgyu Kim <eulgyukim@snu.ac.kr>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 byoungyoung@snu.ac.kr, jjy600901@snu.ac.kr
References: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/23/26 9:41 PM, Eulgyu Kim wrote:
> Hello,
>
> We encountered a "KASAN: slab-use-after-free Write in sk_skb_reason_drop"
> on kernel version v7.0.
>
> As this memory corruption bug seems to require `CAP_NET_ADMIN`,
> we report this in public mailing list.
>
> We have included the following items below:
> - C reproducer (~100 lines)
> - kernel delay patch
> - KASAN crash log
>
> To reliably trigger the race condition bug, we patched the kernel
> to inject a delay at a specific point.
>
> The kernel config used is the same as the syzbot configuration.
>
> Unfortunately, we do not have a fix ready for this bug yet.
> As this issue was identified via fuzzing and we have limited background,
> we find it challenging to propose a correct fix or evaluate
> its potential severity.
>
> We hope this report helps address the issue. Please let us know
> if any further information is needed.
>
> Thank you.
>
> Best Regards,
> Eulgyu Kim
>
>
>
> kernel delay patch:
> ==================================================================
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index c492fda6f..ba7078e18 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1891,6 +1891,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>              !tfile->detached)
>                  rxhash = __skb_get_hash_symmetric(skb);
>
> +       if (strcmp(current->comm, "slowme") == 0) {
> +               mdelay(2000);
> +       }
> +
>          rcu_read_lock();
>          if (unlikely(!(tun->dev->flags & IFF_UP))) {
>                  err = -EIO;
> ==================================================================
>

Hi Eulgyu,


I think this is caused by the lack of napi_mutex protection, and the 
queue detach path seems to have the same issue.

The fix could be this:

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..6a0bbd4def76 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -289,8 +289,12 @@ static void tun_napi_disable(struct tun_file *tfile)

  static void tun_napi_del(struct tun_file *tfile)
  {
-       if (tfile->napi_enabled)
-               netif_napi_del(&tfile->napi);
+       if (!tfile->napi_enabled)
+               return;
+
+       mutex_lock(&tfile->napi_mutex);
+       netif_napi_del(&tfile->napi);
+       mutex_unlock(&tfile->napi_mutex);
  }

  static bool tun_napi_frags_enabled(const struct tun_file *tfile)
@@ -1783,6 +1787,12 @@ static ssize_t tun_get_user(struct tun_struct 
*tun, struct tun_file *tfile,

                 if (frags) {
                         mutex_lock(&tfile->napi_mutex);
+                       if (unlikely(tfile->detached ||
+ rcu_access_pointer(tfile->tun) != tun)) {
+                               err = -EBUSY;
+  mutex_unlock(&tfile->napi_mutex);
+                               goto out;
+                       }
                         skb = tun_napi_alloc_frags(tfile, copylen, from);
                         /* tun_napi_alloc_frags() enforces a layout for 
the skb.
                          * If zerocopy is enabled, then this layout will be
@@ -1981,6 +1991,7 @@ static ssize_t tun_get_user(struct tun_struct 
*tun, struct tun_file *tfile,
                 mutex_unlock(&tfile->napi_mutex);
         }

+out:
         return err ?: total_len;
  }

