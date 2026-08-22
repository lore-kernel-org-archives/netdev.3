Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DF28030E
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432304; cv=none; b=grLzbfED0UZGEItzN6pRlfuACDyJE5x6nPydPIir0Obt8MonwxttfXDqlJUjNiaGZm3JS09Wsj2TegaFJI8mY4UZAnmYDVIulQGpSjIXLynqGA4MFsVKPXdgD7NgTz25YVYBl1zmi6SVVDvPRuzuAT1eh2LBxZ5bIuzFtVCs8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432304; c=relaxed/simple;
	bh=oFI6RWSi8gCXVBUVsnMtRZ+RMtr/ud7vdRETxYQzABE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ob0I4OAsJj2YoLarqkijkp0Tqp478qJNXFbkGjx/lo9FGJqe7GOL1LuHAnzRGpDaiJEf/QiLX5r4W+i3VIYo8L/Z8k518kyO1bAH54a2UfDe5P79wwmV0quMFnKe2X0RhNYjDJCDCHu1YBYBhzP78vmyVay0srrOtvE241jF89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otxKvGcA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otxKvGcA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80bb41f7f3cso20913857b3.2
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787432301; x=1788037101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tSv5OaXOkTNhvVg6RpW8LgIgc5fPTE2CwL1kgRbvrb0=;
        b=otxKvGcAiczffAyit1dIf0mBDKxtPyNGekBpllTMeSx/ZpkMN2WRxH0/MtKCIwSNDq
         ePqlcAR+LGH7tq4A4k4cv2ayjrLuujLlF/xr0uN+533uXWgzU2vDJZvLNjP2HUAXXFA/
         ZG3F6JP95w98s+4YYkBfxgRfSqX297VWd1VL1ynibU0puU+e3J1VbhlrXGgu/Hsy77fe
         GxHcrsw5Ky1PpRK+uDJoGHsVmDel91VRwYVg8eDvn0dBeEdLsbbyYY7q4UzYhTM33lH5
         SwU++1Vr3mXVojggFANT16CeNpYix4wPUInSb8PcwAhRpCq+Ctr7rppi8KNQrB5gY88J
         BCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787432301; x=1788037101;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSv5OaXOkTNhvVg6RpW8LgIgc5fPTE2CwL1kgRbvrb0=;
        b=W+4dDgGmz9zhnxbKXn1WdV51oDOtSP4hf++T70J3pnbrStacmFhuiia7Bvap8Prak2
         YmqvENscKIa4fbMJymCQC+/uWBZeyVaMCTd5YM60D+HWplxgQnAT5Q8m4Zm0DnD/ldjr
         5ezwdTVS6sEyOs2FMB3oZpA1bWn8ty/Yn8tmztNQzD18dIZNNsmiugLtpUNvEa4BOhkT
         BTueBpZK5UsYzcyResFjk/HYmUDnudEAQeA2G/emTu/UD0Du2i/idQSGm4IwA9L5CuqP
         oDm4PnLl2UalvpdFvmacQchzh6oy+xxQ2xPaxqJLPowSa4TIK9KTPUdgX7Z8PvoYBSmF
         YEhg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+oNTRlRiXzUUR9Hr9cMmURPR/L6JwUH4TfG+6SODlTRX9ikeX98Fnd6mmtNTXDGJZ7mKvb44=@vger.kernel.org
X-Gm-Message-State: AFuF++nvdYiSYTkBME5FlkjRRLq2QgGpRjfuiWYnm8sEfpeh+kf5Z2ux
	gLN04WDqjcg4buF0eoLfOInVICtBhL3RV0Z9KnO9bRkeGPaM8i6sZbbN
X-Gm-Gg: AR+sD125gnZs9h/00L6cttvGTJU672DkVj1I85ykicBQED4Vl0kgXusvZOA9QV5j3Qs
	FfCoysOBaPj2w0HzXDWDRiZ3a1pXl7FX+g61eAsh+W4WH5Y0XzNYIVFaNjezfvRPtxo7FJvL3zV
	+lTwj6uvF3P6q8gqBIA+xkcrqs9ylqHQKiaHUtM87bHRYhIoB0moNUaDd0ZFj13KqOHq3AzTx6r
	LOXXRSdHVikWYU4e2nyZ68AMQdq+ZPk4YxpLgj6ww3QHW87A92pgj0OZUdl92aPQb4B/wxwB/Yg
	WrJatteiXsFxuG4krphuLSMKYzGPErQ1rHUzSq29M2oETd6o+ktgbR+jUY3JQGQ6uDp6MzQoRtM
	HybE3+Yp9a5K/cpju9DxSGHqZOklBBCgA//ttX7ZRgbXl4jnkwVmVZGdMTZQrLAYC/bGg92rch/
	aocYk7lcuYSpISSa18sBgEAgn7PU58wMhtQ11vTKUqGzgBnc5FqSN0A3hrFtddxy6oa3QKB3XMZ
	zvdRgusYohKh2YYqJYla1Jvd9BSbFRDVPhwLSHQeg==
X-Received: by 2002:a05:690e:4891:10b0:66c:fec4:dd7b with SMTP id 956f58d0204a3-66cfec4df7amr42554d50.6.1787432300903;
        Sat, 22 Aug 2026 13:58:20 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4624eacsm1286196d50.3.2026.08.22.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 13:58:20 -0700 (PDT)
Date: Sat, 22 Aug 2026 16:58:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Norbert Szetei <norbert@doyensec.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Kuan-Ting Chen <h3xrabbit@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 dev@openvswitch.org, 
 Jongmin Jang <payload.jang@gmail.com>
Message-ID: <willemdebruijn.kernel.38ca099dabfe0@gmail.com>
In-Reply-To: <6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com>
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
 <6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com>
Subject: Re: [PATCH net v4 2/3] net: skbuff: don't skb_tx_error() the source
 skb in skb_zerocopy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Norbert Szetei wrote:
> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.
> 
> Both callers already report the failure on their own drop path.
> nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
> the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
> dropping it here.
> 
> On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
> this error: do_execute_actions() ignores output_userspace()'s return
> value and, unless the upcall was the last action, keeps forwarding the
> same skb through the flow's remaining actions. The uarg is completed
> while that skb is still in flight, telling the producer its buffers are
> free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
> still handles. That flag is what makes esp_input() call skb_cow_data()
> instead of decrypting in place, so a later local ESP delivery can
> decrypt over frags the skb does not own privately.
> 
> Leave error reporting to the callers.
> 
> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
