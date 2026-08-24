Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729A40F735
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573291; cv=pass; b=gzTxnMWfb+CnKLbQKFqOYYeW0T5UAsu94pOsBV3TOukChUDgOkMomyG11ShYtDfY9Ka8hQeHARoXy9B+NAJvr8pviqa2niWgepG4x/oH80/hQJrxJjRjnklAXe6l8uDJ8DqgG1e3tQ1QAzsM+JmvIziOt1aTmux8Uq1Gy/QVAaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573291; c=relaxed/simple;
	bh=vBTgILdC5cit8VdQ8ZKM6MlR+6vzAnYwYk88i/6zjws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/NMMh91xnb1upJMEWmEbzvQDkD+t9gUw+L8j1gNhSkQMnM1PpIp269laHhMynmdMjQ7t2NYdgvT0ji5l87AmGzlABzCtKV2ouiIP4/KV8KnImcSAisOJcpzQv6++x/Anwd5XKETwdXBJNvYNWLA7DnnSwXEpNDJTHbFR/KDhSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHq2xcyZ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHq2xcyZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so607082a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787573288; cv=none;
        d=google.com; s=arc-20260327;
        b=NcgdODF0wal8WCe42B9/8FgxMlqnsS/5o3kQvlL1raVM9Ee7Czbkcd1rYymyvG/3dT
         HxSGXeXU4MeeY08waesOitGI8BeJxbe1Q5N1EhBj2H9I4E9AZeRzVSDLER/x3hn0ChSF
         DrksLslnMhg8SdaT4hQPdcGcmSXJgfA484gDAUzKI7r7iXeuCAPG3ZiJUcWmPvrr3KsF
         ZTtrjF/JJnfSImTbBbncorViqU1gyvoNy3v4mTJnCJeC/EePvi6HeewGLgyKF9bRY6Rb
         hPP3n6Z4V6cItmAUrf1S3SF+T3TP+2f2dyKes6K9XJtR1rvVfLBmM3F/lQZ1Vdd2SN/d
         tiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        fh=3qoZ4n3P1ljOvGhRWWGMVaZnYtq4BfJK+YCJ1nmKySE=;
        b=k6yIXGCcxM2AvBsAuCdFnZKQrr5DF6fZY9+2GPTfOyQl+o6N5MvrKK7IqENKJz3YtX
         ktj15VXCuZFYiIjg6NGz6tXydj335u+UIyHi51VJ/v8EjJigbnTY4kY/RDPHTapC3h0i
         FzbRvIcUhDn7yDGQ2bknISM2ierRbzKZYCvG+c2OjplvTuCVo9PnXiCSRfU8oaJzkWeU
         JefGrAIyl6F5XikdZFjWRvTWi7Sy4p0iJJ2i213mWt1asaMCtn2nESkZIkxssnGd6oK4
         9+DAqYsAEotGdXuucOAhXYujS14w4B90TS+HZ1vLX5DvEWoVY8tu8KOwPXH24mtP5Kmr
         RMIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787573288; x=1788178088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        b=AHq2xcyZDG/r8Y7Y/V0jQvD00Zm97ZlZhUY3Va8JZknaGc0r3jKkwxSPfD1ITUCRbS
         /sQz8IT+8Dl7JDsi9jM/RpzwTKf/lvecVwyoDnzuMBDOtUsm+4YORyPZ98qMb7FAS+No
         1mk7Oi9QjawqHCF5AYMngmYr7LdJiPRq051eyPc6O4HfCgmVDdQ8wI/avd9LaM5wueNf
         AXZ4q4N83LRlCrg1m8DOIIMvHX/rsDDadVDvyhzHFu/IzoUKFC85GcX0jSnVim5kqVo2
         egzaNN3Y/HqbdqLg6+fkuOM3WLKkA44Fw3Mh0GGmCzb8BMclXvoS4WbRb108jMHbF+QI
         /9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787573288; x=1788178088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12nIFyq0ayHc5JfGEDps1S7MzGCCreQskB1ydTzfNLk=;
        b=ibdMl8ZwDX0yZAnMfiqFyD+oIAB1H9gBlHB1b3suYMHkPUWSPJQuJ9Zx4reDM9AjMR
         HqOU3pDgRcnAXcAJRpPfu0UuRLqEf2NBqLwDylmSBUyDCvYizgKOdd9bj5VXYrddAomf
         iidPYtvzG8MisDYpwvFXXhZfXEjSfT1Jk11cZPigOBT+9YOCOYndem9kR3KvKo3RAIAg
         EIKAsU8QedbQclut9/IpF0LJYIoBhX9mDao1vWtSOMaGopdJj2AL13ClkpcLqmZqBc9F
         fRMTAd17Z6jjQLxIIPzcd570FMXa1OP7rHz/ROHG5YV8kOMFbAmSe0NymjvYcnztEk7X
         wWcQ==
X-Gm-Message-State: AFuF++mEsPqerwTMoEpYk3odEwwJBPcw/xeOaroyAd761dBA31bS6I2F
	z5RX6fvMZ8fiBHizLGApKmUtMAIVxrxo8jQklg3WPNbQ+4mZlEK6LOOiq1FQtodazp+NNq2GIR9
	cA8LG7hz6/IbdkDLoNi/ePZuWb2IqE4xBMA63d4shBpqF
X-Gm-Gg: AR+sD13cxkgImGRAu/x4fxJAG1hHvQrUWYFb7fRW11bxiDaCywiRkmpYq+oEd9bRtnV
	yrcnnC+4d+qsb6Ef34yrDJiUbEVrz+bc0AsxEJcYhOU6nXKl3wAWSc2IVqC7vy2Ln77NlXw5oLM
	9ZJEfA7ub2UCwUuFU31W6VdfdPyPiUF3Pmz4lL8tdbEpT37ERH3MsFwGZ0WZKdO4NOmON7nuYqt
	+3ciEovX6/VBFrbhaEz7wf9RIh3ZNdHbLnmYvE/P5iiGC/JG/6UzaSC93+QMzNNUvhW2jFfweLw
	JWbXwuTgD/XYQstKEXwM7NiLRaEQUtd22K7wKTwOdVwxfmcJGUSfHoUEBC/CLn/8IBjp9a6tzQ=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr15032938a12.2.1787573287635; Mon, 24 Aug 2026
 05:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164055.3750284-1-nicoyip.dev@gmail.com> <GV1P189MB1988E432599B256A18EED117C6A02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988E432599B256A18EED117C6A02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 20:07:56 +0800
X-Gm-Features: AcwNN1UnPKhgwygIiR7n-fWhZO2XzKWgyAS0-UT8P-TnGmdrb6QuzlFfVBq784U
Message-ID: <CAAo+4rVXE2gsdueg3Z1A1aWvmZthCgQWQjEfC4PbAmSDCBsoDA@mail.gmail.com>
Subject: Re: [PATCH net] tipc: protect node reset trace dump with node lock
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 4:36=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> Please decode above stack trace (using linux/scripts/decode_stacktrace.sh=
).
>

Decoded with linux/scripts/decode_stacktrace.sh against
(7.2.0-05126-ga4ff2be345d0-dirty #26).

BUG: KASAN: slab-use-after-free in tipc_link_dump (net/tipc/link.c:2910)
Read of size 4 at addr ffff88811c935800 by task poc/115
Call Trace:
 tipc_link_dump (net/tipc/link.c:2910)
 tipc_node_dump (net/tipc/node.c:3136)
 trace_event_raw_event_tipc_node_class (net/tipc/trace.h:327)
 tipc_node_reset_links (net/tipc/trace.h:360 / net/tipc/node.c:1337)
 tipc_rcv (net/tipc/node.c:1851 / net/tipc/node.c:2159)
 tipc_udp_recv (net/tipc/udp_media.c:389)
Allocated by task 0:
 tipc_link_create (net/tipc/link.c:490)
 tipc_node_check_dest (net/tipc/node.c:1285)
 tipc_disc_rcv (net/tipc/discover.c:252)
Freed by task 117:
 kfree (mm/slub.c:6692)
 tipc_node_link_down (net/tipc/node.c:1090)
 tipc_node_delete_links (net/tipc/node.c:1326)
 bearer_disable (net/tipc/bearer.c:414)

The KASAN is obtained by using the following kernel-side delay()
instrumentation to make the reproduction deterministic.

```
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..0e7cdbee9459 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -34,6 +34,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */

+#include <linux/delay.h>
 #include "core.h"
 #include "link.h"
 #include "node.h"
@@ -3129,7 +3130,11 @@ int tipc_node_dump(struct tipc_node *n, bool
more, char *buf)
        i +=3D scnprintf(buf + i, sz - i, " media: ");
        i +=3D tipc_media_addr_printf(buf + i, sz - i, &n->links[0].maddr);
        i +=3D scnprintf(buf + i, sz - i, "\n");
-       i +=3D tipc_link_dump(n->links[0].link, TIPC_DUMP_NONE, buf + i);
+       {
+               struct tipc_link *l0 =3D n->links[0].link;
+               mdelay(50);
+               i +=3D tipc_link_dump(l0, TIPC_DUMP_NONE, buf + i);
+       }
        i +=3D scnprintf(buf + i, sz - i, " inputq: ");
        i +=3D tipc_list_dump(&n->links[0].inputq, false, buf + i);

@@ -3138,7 +3143,11 @@ int tipc_node_dump(struct tipc_node *n, bool
more, char *buf)
        i +=3D scnprintf(buf + i, sz - i, " media: ");
        i +=3D tipc_media_addr_printf(buf + i, sz - i, &n->links[1].maddr);
        i +=3D scnprintf(buf + i, sz - i, "\n");
-       i +=3D tipc_link_dump(n->links[1].link, TIPC_DUMP_NONE, buf + i);
+       {
+               struct tipc_link *l1 =3D n->links[1].link;
+               mdelay(50);
+               i +=3D tipc_link_dump(l1, TIPC_DUMP_NONE, buf + i);
+       }
        i +=3D scnprintf(buf + i, sz - i, " inputq: ");
        i +=3D tipc_list_dump(&n->links[1].inputq, false, buf + i);
```

>
> It is not correct using read lock because trace_tipc_node_reset_links() a=
ccesses link's queues that tipc_rcv() might access concurrently.
> Please test this:
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 683a136e53ef..bd91378b7540 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node =
*n)
>
>         pr_warn("Resetting all links to %x\n", n->addr);
>
> +       tipc_node_write_lock(n);
>         trace_tipc_node_reset_links(n, true, " ");
> +       tipc_node_write_unlock_fast(n);
>         for (i =3D 0; i < MAX_BEARERS; i++) {
>                 tipc_node_link_down(n, i, false);
>         }
>
> >        for (i =3D 0; i < MAX_BEARERS; i++) {
> >               tipc_node_link_down(n, i, false);
> >        }
>
>

No problem, I will send a v2 to correct the fix.

Best regards,
Chengfeng
