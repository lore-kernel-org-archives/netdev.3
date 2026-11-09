Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253553;
	b=kjTNOSga45i0mQjZfeUsG3Q5/F/ulByNjfMfAvWiq04dE5I3StyP+FlQyt4i4+BqPyYF
	 wMRj7IHmQNO7YZSKNtjTxoQO1kojT4UppQe2PUINdOVRChBjVw/amoHp1pzW7QlEyKeoc
	 RyPVcMcR+Zc5kD/wcBDNfzbTdZ6NKeFyKHbQh6+xkFmFaHGDaqE1FGlszfRcz/viELGFx
	 1x5Oq0B1OL2rTDG9/0aYCwrv2YJDSSPkXOojKHhK+97Uoi8yNYai0DI7MlZPHQ2Fr3YvX
	 Rp5NY6QPP4BjTmfJs7PoXxi82cwBmODmg0NX7u9DpnmpZgGc3EkH8GvvDbDF4pVIQqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
	b=CFKHuIif6quUmiZREY1X3ljSu5y7CpBKYOhTfWWYiRozuC0PRBmT/EENc0aFRBfoLY9F
	 z/TUTEmUOLSXTvjgYDHX9iRT0krK/7Rv/5Y5GL7FCOhkMk+7rj5nfmb8XGpRex3hu6aC/
	 OutR3KETvJ589IudLpByLvW9HP4YP1xCY0iRghmDI+rScgyO6Np1mLwAiffIxqOKugvQX
	 CFdX35JJwVXGkqnL6kAHXW3QjXVY97jIr+WKDnQ9xEqSV1MmveYlZNyYIcFHecNvGOxHD
	 9HRKeqv+UUcB4ccf8xbbBJTJnElz5L/9QLYizeECxlKOmVyR6mNu9TmUkU0jZe3VoHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ercuwi9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416D606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1416D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ercuwi9C
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so10005ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 11:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253552; cv=none;
        d=google.com; s=arc-20260327;
        b=j1Z5cMZfnQG+cC84qDI/7sQ+U+K19KN7lu3RbnkgfhMmIVwrdT2HZEKQHTW1P0XnjJ
         XCncaOrAScNAX5XAopk+ciho671Vr+dEAvdXoOMDqFrM9xiYHui1zurdhFTPt1Hxhsuc
         pYlV39BRJnuumu1PRtFpp5FBOUFgR82LtUHsmICetDFB8VTZPkUYNs116JV4NJbBND2Y
         7AQDCwZna3b//az3nKK5HNfc3GckAKJlWPkckkx77qKupi7F6p8CkaH1iRXWV0mgPcs5
         oGB8AuukKnPWEn0FYkUK0LTZHrhpk998+xWbEcRuXddXSATUh8TefvDIDpizx4axC7pW
         WAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        fh=3Tx6BZnwOY9nyymmsikAIffq6zqNZH1TF7Y21imbe+0=;
        b=dGjF5a9EQYd63i77ggWPPmtbMMfr9R+ctNx9mbaMVUAJvzN4mhMIEcnp61NuUCBfXo
         aOAjpE6MhK7UbV9I+bYz8ffHu9rfIDBZ2imsGHMjohBxFs/seC1BKojsG0TuZt9cu6iz
         ZNzvaCXTKn1v8An5g6MHRkke+74c2KHBVfmr76EkZTp/PH2IiXixGo2miYhmHppWNj41
         6tJnNekm35tCg4VF8j0LGxjsoobydaGtO4N1IbsamZQ5kqRZChBjpKE4c4HZ25+14IsF
         yx0r2Eb/pxKbxcTgMJNZuPndZZ3pWkAbA+S3KVgyHa4s8Ujvoz3eew2R0Q/E/OlN8IyJ
         VtRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253552; x=1794858352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        b=ercuwi9CYDzC+T4JGz/F0D3B+85z2Syi6RARIORqBqZuGpbJ/zyh7Jg7ftBxmI87m7
         V9LMsYyHH/UWGGm0BjUJvBOE9ZGwVYxTtu00M25zOLX13MW4eXH28pNAo1gxWRZVUkdr
         lj9BOW1uoh+Vliox898zW5pmTqaWmJV+7MCuQa8b2jfUCp4U4nzzaPPgQz5VWRF4SKzG
         seucLzuI4CoQ9dv0qjSZB5fi35fbmV0c0O4gIkbnM0uIozjbfOekgiqU4/vyKxZeRpJf
         /v4ub8l29DZ8IuUctZVr8i+WbJ8DbC/Eki25p7DDotPOQcKq1o532C71uKGcO8AR1sSk
         y94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253552; x=1794858352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        b=acGFvUjBjiegvKEI/VaWAMuc/oGkK4ZeY4R3tRMRtu+bXrBDdLwXGzj6/yMUOBvlgG
         Rjy8iKc4m4XiMXGLh4OuaDBaK8yyQljL4ekl71+m4o0EN/Ey1+UH2dYuwRw7s1/yByVj
         3AvSOXI3R7uzUay/FdynNSiCJCrXzSYoAzIgouTUnVYae99Ig/vii7olCAIbZSgVerD/
         hSlmCMd40OMZfU8qro0Q8w2eBi01FWEXpPl118h75LhMyKaqpHvqwnyIB7l52ARllaSS
         8k+4mRiZTdS5kUkSpnBwW3ZV8kkj8MbvM+6dMOL62fZlQY6UAJouOcRbt6CrSB5Oen2w
         j13A==
X-Forwarded-Encrypted: i=1; AL+hErH1gof897hsHZB2Deu+YbeGWo9B0ON5erp3KXIqACyJS8HWPWKVX7j+KwYsVGERjHpUlUW1tgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+g8Cmir6K9rkNxj9x5/b4WGVHCadi3C1H3m4eNlwWEcp1OfnQD
	wPoeL4c9RFm8VpN3njn78k7E8x//tAo1hRA/c+WRgLkiMvnLHLbANmGbKDJNZWxkeiLbp0DK2rn
	CBFd3NOSaJ4m5KTBoYwQVSOdlDE5wDhMCzYkFLhOW
X-Gm-Gg: AYBFou0rNOFBAkk3tu5zYZ3VXKIkwdC0M2jsOHGaXtZADbDgXmqVHeA5rJuZWudWj11
	2LZDnIjm7XYyxMcWDUbEuRJsHbRtopZQb9TgJWr3V2jh1gwIec5s+s6hsudbgF5Z3WNI5Cbe/Up
	HaSKu/VrCs3nTuJJQdBKi/b49FqYIQtveS4UUEv12Ilw+g77RjRwc/FBtvAoKzJvNDc14oQ4TFI
	YB4qV+HZY4plpYbUN/vmg/N2SnlJiJCsMBiZec2p+va2LClJclJ1MMkxaZeyziIalA3czQJ9C73
	MVJ08Ed6rLmoc9FYpOkZWTMOkNVIGHy8vitjugMTHRf8MFqJtcj+vWegLpWrj7eTyaPZX9BNEwZ
	z9MtBCyIBlo1aZsKJ7J5TPOdCAoclu8TCQUVNOouKNZNpwfYjMbpU1Lx2AEs5c1ZHRpUDeC1b86
	anpwtCgFsZ/l5yI8prJetdF17NWaSyF3UCltWgKBI=
X-Received: by 2002:a17:902:f611:b0:2e6:d25:d874 with SMTP id
 d9443c01a7336-2edb812e0bbmr796845ad.10.1794253551599; Mon, 09 Nov 2026
 11:45:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 9 Nov 2026 11:45:40 -0800
X-Gm-Features: AclHuK_whYsAe78BgacGejquIYJ9dQ31ukLprOco_opsVCNz0hY1b_kOtAwu6a4
Message-ID: <CAEAWyHerrErox7nuZVau0T++ymEhF7jfo1rccxtOqyXKm--Kqg@mail.gmail.com>
Subject: Re: [PATCH net] gve: bound the device reported RSS sizes in the RSS query
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Hariprasad Kelam <hkelam@marvell.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:01=E2=80=AFPM Yehyeong Lee <yhlee@isslab.korea.ac=
.kr> wrote:
>
> gve_adminq_process_rss_query() copies priv->rss_key_size bytes and
> priv->rss_lut_size words out of the admin queue buffer.  Both sizes come
> from the device: gve_parse_device_option() takes them from the RSS device
> option with no validation, and gve_adminq_describe_device() stores them.
> They are 16 bit fields, so either can be up to 65535.
>
> The source is one GVE_ADMINQ_BUFFER_SIZE block and the payload starts
> after the descriptor, so it holds at most 4088 bytes.  The only length
> test compares the sum with descriptor->total_length, which the same devic=
e
> wrote, and it is computed into a u16:
>
>         u16 hash_lut_length;
>         ...
>         hash_lut_length =3D priv->rss_lut_size * sizeof(*rxfh->indir);
>
>         if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length !=
=3D
>             total_memory_length) {
>
> A lut size of 16384 makes that product 65536, which truncates to zero, so
> the device only has to report a total_length of 48 to pass.  The loop the=
n
> reads 16384 words, 65536 bytes, out of a 4096 byte block, and the walk
> lands in rxfh->indir, which the ethtool core sized from the same device
> value.  ETHTOOL_GRSSH and ETHTOOL_GRXFHINDIR hand that to the caller and
> neither needs CAP_NET_ADMIN, net/ethtool/ioctl.c exempts them.
>
> Reject sizes that do not fit the buffer, and compute the lut length in a
> type that cannot truncate.
>
> In the driver the block is dma_pool memory, so KASAN does not annotate it
> and the contents of the neighbouring blocks leak with no report at all;
> the report below comes from a KUnit harness that hands the handler a
> kmalloc block of the same size, injects the device reply, and is not part
> of this patch.  Unpatched, a lut of 16384 and a lut of 1022 both read pas=
t
> the block; with the patch both are rejected with -EINVAL, and the sizes
> the driver itself defaults to, 40 and 128, still work.
>
>   BUG: KASAN: slab-out-of-bounds in gve_adminq_process_rss_query+0x3da/0x=
4a0
>   Read of size 4 at addr ffff888002845000 by task kunit_try_catch/54
>
>   CPU: 0 UID: 0 PID: 54 Comm: kunit_try_catch Tainted: G                 =
N  7.3.0-dirty #11 PREEMPT(lazy)
>   Tainted: [N]=3DTEST
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x3f/0x50
>    print_report+0xcd/0x620
>    ? gve_adminq_process_rss_query+0x3da/0x4a0
>    kasan_report+0xde/0x110
>    ? gve_adminq_process_rss_query+0x3da/0x4a0
>    gve_adminq_process_rss_query+0x3da/0x4a0
>    gve_rss_run.constprop.0+0xa7/0x1a0
>    ? __pfx_gve_rss_run.constprop.0+0x10/0x10
>    ? __pfx_read_tsc+0x10/0x10
>    ? ktime_get_ts64+0x192/0x250
>    kunit_try_run_case+0x1ca/0x4b0
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? kthread_affine_node+0x247/0x360
>    ? __pfx_kthread_affine_node+0x10/0x10
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x34d/0x620
>    ? __pfx_ret_from_fork+0x10/0x10
>    ? __switch_to+0x22/0xde0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x19/0x30
>    </TASK>
>
>   Allocated by task 54:
>    kasan_save_stack+0x33/0x60
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x8f/0xa0
>    __kmalloc_noprof+0x19b/0x3e0
>    kunit_kmalloc_array+0x1b/0x50
>    gve_rss_ctx_init+0x40a/0x910
>    gve_rss_run.constprop.0+0x93/0x1a0
>    kunit_try_run_case+0x1ca/0x4b0
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ret_from_fork+0x34d/0x620
>    ret_from_fork_asm+0x19/0x30
>
>   The buggy address belongs to the object at ffff888002844000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 0 bytes to the right of
>    allocated 4096-byte region [ffff888002844000, ffff888002845000)
>
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28=
40
>   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>   flags: 0x4000000000000040(head|zone=3D1)
>   page_type: f5(slab)
>   raw: 4000000000000040 ffff888001042140 dead000000000122 000000000000000=
0
>   raw: 0000000000000000 0000000000040004 00000000f5000000 000000000000000=
0
>   head: 4000000000000040 ffff888001042140 dead000000000122 00000000000000=
00
>   head: 0000000000000000 0000000000040004 00000000f5000000 00000000000000=
00
>   head: 4000000000000003 ffffea00000a1001 00000000ffffffff 00000000ffffff=
ff
>   head: 0000000000000000 0000000000000000 00000000ffffffff 00000000000000=
00
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffff888002844f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    ffff888002844f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffff888002845000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                      ^
>    ffff888002845080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff888002845100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> Fixes: fa46c456fa6e ("gve: Add RSS adminq commands and ethtool support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Similarly to https://lore.kernel.org/netdev/CAEAWyHdJNjhV4biOFR+cw0MWNMZHUT=
638+AT9Q83s9G7wyBsgw@mail.gmail.com/,
the driver already provides an 'available_length' field as part of
gve_adminq_query_rss_config(). So this should be dropped too.

> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 8b215fca9c1b63..1ba658cb2942be 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1615,7 +1615,7 @@ static int gve_adminq_process_rss_query(struct gve_=
priv *priv,
>                                         struct ethtool_rxfh_param *rxfh)
>  {
>         u32 total_memory_length;
> -       u16 hash_lut_length;
> +       u32 hash_lut_length;
>         void *rss_info_addr;
>         __be32 *lut;
>         u16 i;
> @@ -1623,6 +1623,14 @@ static int gve_adminq_process_rss_query(struct gve=
_priv *priv,
>         total_memory_length =3D be32_to_cpu(descriptor->total_length);
>         hash_lut_length =3D priv->rss_lut_size * sizeof(*rxfh->indir);
>
> +       if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length >
> +           GVE_ADMINQ_BUFFER_SIZE) {
> +               dev_err(&priv->dev->dev,
> +                       "rss sizes from device do not fit the adminq buff=
er: key %u lut %u\n",
> +                       priv->rss_key_size, priv->rss_lut_size);
> +               return -EINVAL;
> +       }
> +
>         if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length !=
=3D total_memory_length) {
>                 dev_err(&priv->dev->dev,
>                         "rss query desc from device has invalid length pa=
rameter.\n");
>
> base-commit: 787268686c64be60023743b527645a907e38ccca
> --
> 2.43.0
>
